return {
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown",
        lazy = true,
        keys = {
            { "<leader>jd", "<cmd>RenderMarkdownToggle<CR>", desc = "Preview Markdown" },
        },
        dependencies = { "mini.icons" },
        opts = { latex = {
            enabled = false,
        } },
        config = function(_, opts)
            require("render-markdown").setup(opts)
        end,
    },
}
