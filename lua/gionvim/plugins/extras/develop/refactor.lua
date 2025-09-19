local pick = function()
    local refactoring = require("refactoring")
    refactoring.select_refactor()
end

return {
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        cmd = "Refactor",
        keys = {
            { "<leader>rf", "", desc = "refactoring", mode = { "n", "x" } },
            {
                "<leader>rfs",
                pick,
                mode = { "n", "x" },
                desc = "Refactor",
            },
            {
                "<leader>rfe",
                function()
                    return require("refactoring").refactor("Extract Function")
                end,
                mode = { "n", "x" },
                desc = "Extract Function",
                expr = true,
            },
            {
                "<leader>rft",
                function()
                    return require("refactoring").refactor("Extract Function To File")
                end,
                mode = { "n", "x" },
                desc = "Extract Function To File",
                expr = true,
            },
            {
                "<leader>rfv",
                function()
                    return require("refactoring").refactor("Extract Variable")
                end,
                mode = { "n", "x" },
                desc = "Extract Variable",
                expr = true,
            },
            {
                "<leader>rfi",
                function()
                    return require("refactoring").refactor("Inline Variable")
                end,
                mode = { "n", "x" },
                desc = "Inline Variable",
                expr = true,
            },
            {
                "<leader>rfb",
                function()
                    return require("refactoring").refactor("Extract Block")
                end,
                mode = { "n", "x" },
                desc = "Extract Block",
                expr = true,
            },
            {
                "<leader>rfk",
                function()
                    return require("refactoring").refactor("Extract Block To File")
                end,
                mode = { "n", "x" },
                desc = "Extract Block To File",
                expr = true,
            },
        },
        dependencies = { { "plenary.nvim" }, { "nvim-treesitter" } },
        opts = {
            prompt_func_return_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            prompt_func_param_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            printf_statements = {},
            print_var_statements = {},
            show_success_message = true,
        },
        config = function(_, opts)
            require("refactoring").setup(opts)
        end,
    },
}
