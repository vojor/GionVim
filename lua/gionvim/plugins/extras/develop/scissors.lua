return {
    {
        "chrisgrieser/nvim-scissors",
        lazy = true,
        keys = {
            {
                "<leader>ee",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "Snippet: Edit",
            },
            {
                "<leader>ea",
                function()
                    require("scissors").addNewSnippet()
                end,
                mode = { "n", "x" },
                desc = "Snippet: Add",
            },
        },
        opts = {},
    },
}
