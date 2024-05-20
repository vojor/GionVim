return {
    -- 自动关闭和重命名标签
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
        ft = { "xml", "html", "markdown", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable = true,
                    enable_rename = true,
                    enable_close = true,
                    enable_close_on_slash = true,
                },
            })
        end,
    },
}
