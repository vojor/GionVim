local pick = function()
    local fzf_lua = require("fzf-lua")
    local results = require("refactoring").get_refactors()
    local refactoring = require("refactoring")

    local opts = {
        fzf_opts = {},
        fzf_colors = true,
        actions = {
            ["default"] = function(selected)
                refactoring.refactor(selected[1])
            end,
        },
    }
    fzf_lua.fzf_exec(results, opts)
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
                mode = "v",
                desc = "Refactor",
            },
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
