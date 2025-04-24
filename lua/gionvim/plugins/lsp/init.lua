return {
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        keys = {
            { "<leader>i", "", desc = "relay" },
            {
                "<leader>ii",
                function()
                    Snacks.picker.lsp_config()
                end,
                desc = "Server Status",
            },
            { "<leader>if", "<cmd>LspInfo<CR>", desc = "Server Information" },
            { "<leader>is", "<cmd>LspStart<CR>", desc = "Start Server" },
            { "<leader>ip", "<cmd>LspStop<CR>", desc = "Stop Server" },
            { "<leader>ir", "<cmd>LspRestart<CR>", desc = "Restart Server" },
        },
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                opts = {
                    ensure_installed = { "marksman", "lemminx", "autotools_ls" },
                    automatic_installation = false,
                },
            },
        },
        opts = function()
            local ret = {
                diagnostics = {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = GionVim.config.icons.diagnostics.Error,
                            [vim.diagnostic.severity.WARN] = GionVim.config.icons.diagnostics.Warn,
                            [vim.diagnostic.severity.HINT] = GionVim.config.icons.diagnostics.Hint,
                            [vim.diagnostic.severity.INFO] = GionVim.config.icons.diagnostics.Info,
                        },
                    },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    float = { source = "if_many" },
                },
                inlay_hints = { enabled = true, exclude = {} },
                codelens = { enabled = true },
            }
            return ret
        end,
        config = function(_, opts)
            GionVim.lsp.setup()

            if opts.inlay_hints.enabled then
                GionVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
                    if
                        vim.api.nvim_buf_is_valid(buffer)
                        and vim.bo[buffer].buftype == ""
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                    then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                    end
                end)
            end

            if opts.codelens.enabled and vim.lsp.codelens then
                GionVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
                    vim.lsp.codelens.refresh()
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        buffer = buffer,
                        callback = vim.lsp.codelens.refresh,
                    })
                end)
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            vim.lsp.set_log_level("error")

            require("gionvim.config.loadpath").autoload("gionvim.plugins.lsp.langue", {
                ignore_files = { "sqls.lua" },
                verbose = true,
                reload = true,
                use_cache = true,
                callbacks = {
                    on_success = function(mod)
                        print("✅ Succeed: " .. mod)
                    end,
                    on_error = function(mod, err)
                        print("❌ Failure: " .. mod .. "\n" .. err)
                    end,
                    on_finish = function()
                        print("🎉 All modules processed!")
                    end,
                },
            })

            require("gionvim.plugins.lsp.keymaps")
        end,
    },
}
