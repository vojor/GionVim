return {
    -- LSP basic service
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>i", "", desc = "serve" },
            {
                "<leader>ii",
                function()
                    Snacks.picker.lsp_config()
                end,
                desc = "Lsp Configuration Information",
            },
            { "<leader>is", "<cmd>LspStart<CR>", desc = "Start LSP Server" },
            { "<leader>ip", "<cmd>LspStop<CR>", desc = "Stop LSP Server" },
            { "<leader>ir", "<cmd>LspRestart<CR>", desc = "Restart LSP Server" },
        },
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                opts = {
                    ensure_installed = { "marksman", "lemminx" },
                    automatic_installation = false,
                },
            },
        },
        opts = function()
            local ret = {
                diagnostics = {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = GionConfig.icons.diagnostics.Error,
                            [vim.diagnostic.severity.WARN] = GionConfig.icons.diagnostics.Warn,
                            [vim.diagnostic.severity.HINT] = GionConfig.icons.diagnostics.Hint,
                            [vim.diagnostic.severity.INFO] = GionConfig.icons.diagnostics.Info,
                        },
                    },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    virtual_text = { spacing = 4, prefix = "●", source = "if_many" },
                    float = { source = "if_many" },
                },
                inlay_hints = { enabled = true, exclude = {} },
                codelens = { enabled = false },
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

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = function(diagnostic)
                    local icons = GionConfig.icons.diagnostics
                    for d, icon in pairs(icons) do
                        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                            return icon
                        end
                    end
                end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            vim.lsp.set_log_level("error")

            local filename = {
                "basedpy",
                "bashls",
                "clangd",
                "jsonls",
                "lemminx",
                "luals",
                "marksman",
                "neocmake",
                "sqls",
                "taplo",
                "vimls",
                "yamlls",
            }

            for _, name in ipairs(filename) do
                require("gionvim.plugins.lsp.lang." .. name)
            end

            require("gionvim.plugins.lsp.keymaps")
        end,
    },
}
