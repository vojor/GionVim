return {
    -- 函数重构
    -- dependencies neovim nighty
    {
        "ThePrimeagen/refactoring.nvim",
        enabled = false,
        lazy = true,
        cmd = "Refactor",
        keys = {
            { "<leader>rfe", mode = "x", desc = "Extract Function" },
            { "<leader>rft", mode = "x", desc = "Extract Function To File" },
            { "<leader>rfv", mode = "x", desc = "Extract Variable" },
            { "<leader>rfi", mode = { "n", "x" }, desc = "Inline Variable" },
            { "<leader>rfb", desc = "Extract Block" },
            { "<leader>rfk", desc = "Extract Block To File" },
        },
        dependencies = {
            { "plenary.nvim" },
            { "nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup({
                prompt_func_return_type = {
                    go = false,
                    java = true,

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
            })
            vim.keymap.set("x", "<leader>rfe", function()
                require("refactoring").refactor("Extract Function")
            end)
            vim.keymap.set("x", "<leader>rft", function()
                require("refactoring").refactor("Extract Function To File")
            end)
            vim.keymap.set("x", "<leader>rfv", function()
                require("refactoring").refactor("Extract Variable")
            end)
            vim.keymap.set({ "n", "x" }, "<leader>rfi", function()
                require("refactoring").refactor("Inline Variable")
            end)
            vim.keymap.set("n", "<leader>rfb", function()
                require("refactoring").refactor("Extract Block")
            end)
            vim.keymap.set("n", "<leader>rfk", function()
                require("refactoring").refactor("Extract Block To File")
            end)
        end,
    },
}
