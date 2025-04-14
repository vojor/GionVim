return {
    {
        "chrisgrieser/nvim-chainsaw",
        lazy = true,
        cmd = "Chainsaw",
        keys = {
            { "<leader>v", "", desc = "log" },
            {
                "<leader>vl",
                function()
                    require("chainsaw").variableLog()
                end,
                desc = "Add Variable Log",
            },
            {
                "<leader>vo",
                function()
                    require("chainsaw").objectLog()
                end,
                desc = "Add Object Log",
            },
            {
                "<leader>vt",
                function()
                    require("chainsaw").typeLog()
                end,
                desc = "Add Type Log",
            },
            {
                "<leader>va",
                function()
                    require("chainsaw").assertLog()
                end,
                desc = "Add Assert Log",
            },
            {
                "<leader>ve",
                function()
                    require("chainsaw").emojiLog()
                end,
                desc = "Add Emoji Log",
            },
            {
                "<leader>vg",
                function()
                    require("chainsaw").messageLog()
                end,
                desc = "Add Message Log",
            },
            {
                "<leader>vm",
                function()
                    require("chainsaw").timeLog()
                end,
                desc = "Add Time Log",
            },
            {
                "<leader>vr",
                function()
                    require("chainsaw").removeLogs()
                end,
                desc = "Remove Logs",
            },
        },
        opts = {},
    },
}
