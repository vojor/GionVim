return {
    {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        keys = {
            { "<leader>ny", "<cmd>Navbuddy<CR>", desc = "Navbuddy Float Outline" },
        },
        dependencies = {
            {
                "SmiteshP/nvim-navic",
                lazy = true,
                opts = {
                    lsp = {
                        auto_attach = true,
                    },
                    highlight = true,
                },
            },
            { "nvim-lspconfig" },
        },
        opts = {
            window = {
                border = "rounded",
            },
            lsp = {
                auto_attach = true,
            },
        },
    },
}
