return {
    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        dependencies = { { "plenary.nvim" }, { "nvim-lspconfig" } },
        opts = {
            settings = {
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true,
                    quotePreference = "auto",
                },
            },
        },
    },
}
