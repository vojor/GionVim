return {
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        keys = {
            { "<leader>hc", "<cmd>ColorizerToggle<CR>", desc = "Toggle Display Hexadecimal Color" },
        },
        opts = {
            filetypes = {
                "*",
                cmp_docs = { always_update = true },
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                tailwind = true,
            },
        },
    },
    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        lazy = true,
        event = "VeryLazy",
        dependencies = { "nvim-web-devicons" },
        opts = {},
    },
}
