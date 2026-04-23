return {
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        cmd = "Refactor",
        keys = {
            { "<leader>rf", "", desc = "refactoring", mode = { "n", "x" } },
            {
                "<leader>rfs",
                function()
                    return require("refactoring").select_refactor()
                end,
                mode = { "n", "x" },
                desc = "Refactor",
            },
            {
                "<leader>rfe",
                function()
                    return require("refactoring").extract_func()
                end,
                mode = { "n", "x" },
                desc = "Extract Function",
                expr = true,
            },
            {
                "<leader>rft",
                function()
                    return require("refactoring").extract_func_to_file()
                end,
                mode = { "n", "x" },
                desc = "Extract Function To File",
                expr = true,
            },
            {
                "<leader>rfv",
                function()
                    return require("refactoring").extract_var()
                end,
                mode = { "n", "x" },
                desc = "Extract Variable",
                expr = true,
            },
            {
                "<leader>rfi",
                function()
                    return require("refactoring").inline_var()
                end,
                mode = { "n", "x" },
                desc = "Inline Variable",
                expr = true,
            },
        },
        opts = {},
    },
}
