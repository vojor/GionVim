return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "moon",
            styles = {
                comments = { italic = true },
                keywords = { italic = false, bold = true },
                functions = { bold = true },
                variables = { bold = true },
            },
            sidebars = { "qf", "terminal", "neo-tree", "toggleterm" },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
