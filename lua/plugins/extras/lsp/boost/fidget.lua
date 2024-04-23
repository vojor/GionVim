return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            notification = {
                window = {
                    border = "rounded",
                },
            },
            logger = {
                level = vim.log.levels.ERROR,
            },
        },
    },
}
