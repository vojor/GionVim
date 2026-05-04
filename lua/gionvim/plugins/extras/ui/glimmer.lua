return {
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        priority = 10,
        opts = {
            overwrite = {
                yank = { enabled = false },
                search = { enabled = true },
                undo = { enabled = true },
                repo = { enabled = true },
            },
        },
    },
}
