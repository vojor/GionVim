return {
    {
        "FeiyouG/commander.nvim",
        lazy = true,
        dependencies = { "telescope.nvim" },
        keys = {
            {
                "<leader>fN",
                "<cmd>Telescope commander<CR>",
                desc = "Open Commander",
            },
        },
        opts = {
            components = {
                "DESC",
                "KEYS",
                "CAT",
            },
            sort_by = {
                "DESC",
                "KEYS",
                "CAT",
                "CMD",
            },
            integration = {
                telescope = {
                    enable = true,
                },
                lazy = {
                    enable = true,
                    set_plugin_name_as_cat = true,
                },
            },
        },
    },
}
