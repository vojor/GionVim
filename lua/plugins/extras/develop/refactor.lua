return {
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        cmd = "Refactor",
        keys = {
            {
                "<leader>rfe",
                function()
                    require("refactoring").refactor("Extract Function")
                end,
                mode = "x",
                desc = "Extract Function",
            },
            {
                "<leader>rft",
                function()
                    require("refactoring").refactor("Extract Function To File")
                end,
                mode = "x",
                desc = "Extract Function To File",
            },
            {
                "<leader>rfv",
                function()
                    require("refactoring").refactor("Extract Variable")
                end,
                mode = "x",
                desc = "Extract Variable",
            },
            {
                "<leader>rfi",
                function()
                    require("refactoring").refactor("Inline Variable")
                end,
                mode = { "n", "x" },
                desc = "Inline Variable",
            },
            {
                "<leader>rfb",
                function()
                    require("refactoring").refactor("Extract Block")
                end,
                desc = "Extract Block",
            },
            {
                "<leader>rfk",
                function()
                    require("refactoring").refactor("Extract Block To File")
                end,
                desc = "Extract Block To File",
            },
        },
        dependencies = { { "plenary.nvim" }, { "nvim-treesitter" } },
        opts = {
            prompt_func_return_type = {
                go = false,
                java = false,

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            prompt_func_param_type = {
                go = false,
                java = false,

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
        },
    },
}
