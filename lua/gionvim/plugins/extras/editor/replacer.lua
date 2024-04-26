return {
    -- 多个参数替换
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
}
