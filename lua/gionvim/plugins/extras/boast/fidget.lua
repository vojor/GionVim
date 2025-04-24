return {
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            progress = {
                suppress_on_insert = true,
                ignore_done_already = true,
                ignore_empty_message = true,
            },
            notification = {
                filter = vim.log.levels.ERROR,
                window = { border = "rounded" },
            },
            logger = {
                level = vim.log.levels.ERROR,
            },
        },
    },
}
