return {
    -- Manage session
    {
        "folke/persistence.nvim",
        lazy = true,
        event = "BufReadPre",
        opts = {},
        keys = {
            { "<leader>q", "", desc = "session" },
            {
                "<leader>ql",
                "<cmd>lua require('persistence').load()<CR>",
                desc = "Restore The Session For The Current Directory",
            },
            {
                "<leader>qL",
                "<cmd>lua require('persistence').load({ last = true })<CR>",
                desc = "Restore The Last Session",
            },
            {
                "<leader>qt",
                "<cmd>lua require('persistence').stop()<CR>",
                desc = "Session Won't Be Saved On Exit",
            },
            {
                "<leader>qs",
                function()
                    require("persistence").select()
                end,
                desc = "Select Session",
            },
        },
    },
}
