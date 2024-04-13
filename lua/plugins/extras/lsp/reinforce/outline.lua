return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        keys = {
            { "<leader>no", "<cmd>Outline<CR>", desc = "Toggle Outline" },
        },
        opts = {
            outline_window = {
                show_numbers = true,
            },
            preview_window = {
                open_hover_on_preview = true,
            },
            providers = {
                priority = { "lsp", "markdown", "norg" },
                lsp = {
                    blacklist_clients = {},
                },
            },
        },
    },
}
