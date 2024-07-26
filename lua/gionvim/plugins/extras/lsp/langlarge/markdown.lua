return {
    {
        "MeanderingProgrammer/markdown.nvim",
        main = "render-markdown",
        name = "render-markdown",
        lazy = true,
        keys = {
            { "<leader>jd", "<cmd>RenderMarkdown toggle<CR>", desc = "Preview Markdown" },
        },
        opts = {
            latex = { enabled = false },
        },
    },
}
