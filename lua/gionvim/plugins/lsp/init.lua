return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>i", "", desc = "relay" },
            { "<leader>if", "<cmd>LspInfo<CR>", desc = "Server Information" },
            { "<leader>is", "<cmd>LspStart<CR>", desc = "Start Server" },
            { "<leader>ip", "<cmd>LspStop<CR>", desc = "Stop Server" },
            { "<leader>ir", "<cmd>LspRestart<CR>", desc = "Restart Server" },
            { "<leader>il", "<cmd>LspLog<CR>", desc = "Show Lsp Log" },
        },
        dependencies = {
            {
                "mason-org/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                opts = {
                    ensure_installed = { "marksman", "lemminx", "autotools_ls", "basedpyright" },
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
                folds = { enabled = true },
            }
            return ret
        end,
        config = function(_, opts)
            GionVim.format.register(GionVim.lsp.formatter())

            -- inlay hints
            if opts.inlay_hints.enabled then
                Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
                    if
                        vim.api.nvim_buf_is_valid(buffer)
                        and vim.bo[buffer].buftype == ""
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                    then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                    end
                end)
            end

            -- code lens
            if opts.codelens.enabled and vim.lsp.codelens then
                Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
                    vim.lsp.codelens.get()
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        buffer = buffer,
                        callback = vim.lsp.codelens.get,
                    })
                end)
            end

            -- folds
            if opts.folds.enabled then
                Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function(buffer)
                    if GionVim.set_default("foldmethod", "expr") then
                        GionVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
                    end
                end)
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            vim.lsp.log.set_level(vim.log.levels.ERROR)

            local lazyload = require("gionvim.config.pathload")
            local mappings = lazyload.build_mappings({
                atls = { "config", "automake", "make" },
                basedpy = { "python" },
                bashls = { "bash", "sh" },
                clangd = { "c", "cpp" },
                html = { "html" },
                jsonls = { "json", "jsonc" },
                lemminx = { "xml" },
                luals = { "lua" },
                marksman = { "markdown", "markdown.mdx" },
                neocmake = { "cmake" },
                tombi = { "toml" },
                vimls = { "vim" },
                yamlls = { "yaml" },
            })
            lazyload.setup("gionvim.plugins.lsp.langue", {
                mappings = mappings,
                profile = {
                    mode = "dev",
                    top = 5,
                    delay = 3000,
                },
            })
            require("gionvim.plugins.lsp.keymaps")
        end,
    },
}
