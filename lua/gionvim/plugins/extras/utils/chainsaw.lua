return {
    {
        "chrisgrieser/nvim-chainsaw",
        lazy = true,
        keys = {
            { "<leader>v", "", desc = "log" },
            {
                "<leader>vl",
                function()
                    require("chainsaw").variableLog()
                end,
                desc = "Add Variable Log",
            },
        },
        opts = {},
    },
}
