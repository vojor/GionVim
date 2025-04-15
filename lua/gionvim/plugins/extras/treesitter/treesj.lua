return {
    {
        "Wansmer/treesj",
        lazy = true,
        cmd = "TSJToggle",
        keys = {
            {
                "<leader>jg",
                function()
                    require("treesj").toggle()
                end,
                desc = "Node Toggle",
            },
            {
                "<leader>js",
                function()
                    require("treesj").split()
                end,
                desc = "Node Split",
            },
            {
                "<leader>jj",
                function()
                    require("treesj").join()
                end,
                desc = "Node Join",
            },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
}
