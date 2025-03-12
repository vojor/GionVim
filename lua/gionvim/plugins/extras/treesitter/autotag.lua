return {
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
        ft = { "xml", "html", "markdown", "javascript", "typescript" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close_on_slash = true,
                },
            })
        end,
    },
}
