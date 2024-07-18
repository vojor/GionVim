return {
    {
        "AckslD/muren.nvim",
        lazy = true,
        keys = {
            { "<leader>rrg", "<cmd>MurenToggle<CR>", desc = "Toggle Muren Interface" },
            { "<leader>rrf", "<cmd>MurenFresh<CR>", desc = "Open The Muren UI Fresh" },
            { "<leader>rru", "<cmd>MurenUnique<CR>", desc = "Unique Muren" },
        },
        opts = {},
    },
    {
        "MagicDuck/grug-far.nvim",
        lazy = true,
        cmd = "GrugFar",
        opts = {},
    },
}
