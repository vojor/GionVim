return {
    {
        "bassamsdata/namu.nvim",
        lazy = true,
        cmd = "Namu",
        keys = {
            { "<leader>nn", "<cmd>Namu symbols<CR>", desc = "Jump to LSP symbol" },
            { "<leader>nw", "<cmd>Namu workspace<CR>", desc = "LSP Symbols - Workspace" },
        },
        opts = {
            ui_select = { enable = true },
        },
    },
}
