vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})
return {
    {
        "mistweaverco/kulala.nvim",
        lazy = true,
        ft = "http",
        keys = {
            { "<leader>R", "", desc = "+Rest" },
            { "<leader>Rs", "<cmd>lua require('kulala').run()<CR>", desc = "Send the request" },
            { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<CR>", desc = "Toggle headers/body" },
            { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<CR>", desc = "Jump to previous request" },
            { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<CR>", desc = "Jump to next request" },
        },
        opts = {},
    },
}
