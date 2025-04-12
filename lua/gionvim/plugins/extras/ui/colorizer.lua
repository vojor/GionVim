return {
    {
        "catgoose/nvim-colorizer.lua",
        lazy = true,
        keys = {
            { "<leader>hc", "<cmd>ColorizerToggle<CR>", desc = "Toggle Display Hexadecimal Color" },
        },
        opts = {
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                tailwind = true,
            },
        },
    },
}
