vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})
return {
    {
        "mistweaverco/kulala.nvim",
        lazy = true,
        ft = { "http", "rest" },
        keys = {
            { "<leader>R", "", desc = "rest/http", ft = { "http", "rest" } },
            { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<CR>", desc = "Open scratchpad", ft = "http" },
            { "<leader>Rc", "<cmd>lua require('kulala').copy()<CR>", desc = "Copy as cURL", ft = "http" },
            { "<leader>RC", "<cmd>lua require('kulala').from_curl()<CR>", desc = "Paste from curl", ft = "http" },
            {
                "<leader>Rg",
                "<cmd>lua require('kulala').download_graphql_schema()<CR>",
                desc = "Download GraphQL schema",
                ft = "http",
            },
            { "<leader>Ri", "<cmd>lua require('kulala').inspect()<CR>", desc = "Inspect current request", ft = "http" },
            { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<CR>", desc = "Jump to next request", ft = "http" },
            {
                "<leader>Rp",
                "<cmd>lua require('kulala').jump_prev()<CR>",
                desc = "Jump to previous request",
                ft = "http",
            },
            { "<leader>Rq", "<cmd>lua require('kulala').close()<CR>", desc = "Close window", ft = "http" },
            { "<leader>Rr", "<cmd>lua require('kulala').replay()<CR>", desc = "Replay the last request", ft = "http" },
            { "<leader>Rs", "<cmd>lua require('kulala').run()<CR>", desc = "Send the request", ft = "http" },
            { "<leader>RS", "<cmd>lua require('kulala').show_stats()<CR>", desc = "Show stats", ft = "http" },
            { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<CR>", desc = "Toggle headers/body", ft = "http" },
        },
        opts = {},
    },
}
