return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false, bold = true },
                    functions = { bold = true },
                    variables = { bold = true },
                },
                sidebars = { "qf", "terminal", "neo-tree", "toggleterm", "lazyterm" },
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
