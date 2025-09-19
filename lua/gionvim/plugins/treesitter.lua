return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
            local TS = require("nvim-treesitter")
            if not TS.get_installed then
                GionVim.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
                return
            end
            GionVim.treesitter.ensure_treesitter_cli(function()
                TS.update(nil, { summary = true })
            end)
        end,
        lazy = vim.fn.argc(-1) == 0,
        event = { "LazyFile", "VeryLazy" },
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        opts_extend = { "ensure_installed" },
        opts = {
            indent = { enable = true },
            highlight = { enable = true },
            folds = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "diff",
                "editorconfig",
                "git_config",
                "gitcommit",
                "gitignore",
                "html",
                "http",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "python",
                "query",
                "regex",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter")
            if not TS.get_installed then
                return GionVim.error("Please use `:Lazy` and update `nvim-treesitter`")
            elseif type(opts.ensure_installed) ~= "table" then
                return GionVim.error("`nvim-treesitter` opts.ensure_installed must be a table")
            end

            TS.setup(opts)
            GionVim.treesitter.get_installed(true)

            local install = vim.tbl_filter(function(lang)
                return not GionVim.treesitter.have(lang)
            end, opts.ensure_installed or {})
            if #install > 0 then
                GionVim.treesitter.ensure_treesitter_cli(function()
                    TS.install(install, { summary = true }):await(function()
                        GionVim.treesitter.get_installed(true)
                    end)
                end)
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("gionvim_treesitter", { clear = true }),
                callback = function(ev)
                    if not GionVim.treesitter.have(ev.match) then
                        return
                    end

                    -- highlighting
                    if vim.tbl_get(opts, "highlight", "enable") ~= false then
                        pcall(vim.treesitter.start)
                    end

                    -- indents
                    if vim.tbl_get(opts, "indent", "enable") ~= false then
                        GionVim.set_default("indentexpr", "v:lua.GionVim.treesitter.indentexpr()")
                    end

                    -- folds
                    if vim.tbl_get(opts, "folds", "enable") ~= false then
                        if GionVim.set_default("foldmethod", "expr") then
                            GionVim.set_default("foldexpr", "v:lua.GionVim.treesitter.foldexpr()")
                        end
                    end
                end,
            })
        end,
    },
}
