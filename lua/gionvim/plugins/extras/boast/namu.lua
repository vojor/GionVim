return {
    {
        "bassamsdata/namu.nvim",
        lazy = true,
        cmd = "Namu",
        keys = {
            { "<leader>nn", "<cmd>Namu symbols<CR>", desc = "Jump to LSP symbols" },
            { "<leader>nw", "<cmd>Namu workspace<CR>", desc = "LSP Symbols - Workspace" },
            { "<leader>nt", "<cmd>Namu watchtower<CR>", desc = "Lsp Symbols - fallback treesitter" },
            { "<leader>nd", "<cmd>Namu diagnostics<CR>", desc = "Diagnostics - Workspace" },
            { "<leader>nr", "<cmd>Namu treesitter<CR>", desc = "Treesitter Symbols" },
            { "<leader>nh", "<cmd>Namu help<CR>", desc = "Namu Help" },
        },
        opts = {
            ui_select = { enable = false },
        },
    },
}
