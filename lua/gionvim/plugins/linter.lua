return {
    -- Use lua inject diagnostic，code action, etc
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>un", "<cmd>NullLsInfo<CR>", desc = "Show Null-ls Info" },
        },
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                cmd = { "NoneLsInstall", "NoneLsUninstall" },
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-null-ls").setup({
                        ensure_installed = { "markdownlint", "shellcheck", "biome" },
                        automatic_installation = false,
                    })
                end,
            },
        },
        config = function()
            local none_ls = require("null-ls")
            local code_actions = none_ls.builtins.code_actions
            local diagnostics = none_ls.builtins.diagnostics

            local sources = {
                -- Code Action
                code_actions.gitsigns.with({
                    config = {
                        filter_actions = function(title)
                            return title:lower():match("blame") == nil
                        end,
                    },
                }),

                -- Diagnostics
                diagnostics.cmake_lint,
                diagnostics.ltrs,
                diagnostics.selene,
                diagnostics.dotenv_linter,
                diagnostics.editorconfig_checker.with({
                    disabled_filetypes = { "markdown", "tex", "text", "norg" },
                }),
            }

            none_ls.setup({
                sources = sources,
                border = "rounded",
                debug = false,
                diagnostics_config = {
                    underline = true,
                    virtual_text = true,
                    signs = true,
                    update_in_insert = true,
                    severity_sort = true,
                },
                diagnostics_format = "[#{c}] #{m} (#{s})",
                log_level = "error",
            })
        end,
    },
    -- Supplement built-in diagnostic
    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                javascript = { "eslint", "biomejs" },
                javascriptreact = { "eslint", "biomejs" },
                typescript = { "eslint", "biomejs" },
                typescriptreact = { "eslint", "biomejs" },
                json = { "jsonlint", "biomejs" },
                jsonc = { "biomejs" },
                -- lua = { "selene" },
                make = { "checkmake" },
                markdown = { "markdownlint" },
                python = { "ruff" },
                sh = { "shellcheck" },
                vim = { "vint" },
                yaml = { "yamllint" },
                zsh = { "zsh" },
                ["*"] = { "typos" },
            },
            linters = {
                -- selene = {
                --     condition = function(ctx)
                --         return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
                --     end,
                -- },
            },
        },
        config = function(_, opts)
            local M = {}

            local lint = require("lint")
            for name, linter in pairs(opts.linters) do
                if type(linter) == "table" and type(lint.linters[name]) == "table" then
                    lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
                    if type(linter.prepend_args) == "table" then
                        vim.list_extend(lint.linters[name].args, linter.prepend_args)
                    end
                else
                    lint.linters[name] = linter
                end
            end
            lint.linters_by_ft = opts.linters_by_ft

            function M.debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            function M.lint()
                local names = lint._resolve_linter_by_ft(vim.bo.filetype)

                names = vim.list_extend({}, names)

                if #names == 0 then
                    vim.list_extend(names, lint.linters_by_ft["_"] or {})
                end

                vim.list_extend(names, lint.linters_by_ft["*"] or {})

                local ctx = { filename = vim.api.nvim_buf_get_name(0) }
                ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
                names = vim.tbl_filter(function(name)
                    local linter = lint.linters[name]
                    if not linter then
                        GionVim.warn("Linter not found: " .. name, { title = "nvim-lint" })
                    end
                    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
                end, names)

                if #names > 0 then
                    lint.try_lint(names)
                end
            end

            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = M.debounce(100, M.lint),
            })
        end,
    },
}
