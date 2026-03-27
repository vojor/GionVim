return {
    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        dependencies = { { "plenary.nvim" }, { "nvim-lspconfig" } },
        opts = {
            settings = {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
                separate_diagnostic_server = false,
                expose_as_code_action = {
                    "fix_all",
                    "add_missing_imports",
                    "remove_unused",
                    "organize_imports",
                },
                tsserver_max_memory = "4096",
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true,
                    quotePreference = "auto",
                },
            },
        },
    },
}
