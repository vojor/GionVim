return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>dvp", "<cmd>DiffviewOpen<CR>", desc = "Open New Diffview " },
            { "<leader>dvc", "<cmd>DiffviewClose<CR>", desc = "Close Current Diffview " },
            { "<leader>dvh", "<cmd>DiffviewFileHistory<CR>", desc = "View Files History Diff" },
            { "<leader>dvt", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle File Diff Panel" },
            { "<leader>dvr", "<cmd>DiffviewRefresh<CR>", desc = "Update Current Entries And File List" },
            { "<leader>dvu", "<cmd>DiffviewFocusFiles<CR>", desc = "Bring Focus To The File Panel" },
        },
        opts = {
            enhanced_diff_hl = true,
        },
    },
}
