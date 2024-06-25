return {
    {
        "MeanderingProgrammer/markdown.nvim",
        lazy = true,
        keys = {
            { "<leader>jd", "<cmd>RenderMarkdownToggle<CR>", desc = "Preview Markdown" },
        },
        opts = {
            latex_enabled = false,
        },
    },
}
