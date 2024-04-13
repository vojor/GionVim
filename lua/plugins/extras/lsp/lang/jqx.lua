return {
    -- json,yaml
    {
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        keys = {
            { "<leader>jl", "<cmd>JqxList<CR>", desc = "Json List" },
            { "<leader>jn", "<cmd>JqxList null<CR>", desc = "Json Null List" },
            { "<leader>jm", "<cmd>JqxList number<CR>", desc = "Json Number List" },
            { "<leader>js", "<cmd>JqxList string<CR>", desc = "Json String List" },
            { "<leader>ja", "<cmd>JqxList array<CR>", desc = "Json Array List" },
            { "<leader>jo", "<cmd>JqxList object<CR>", desc = "Json Object List" },
            { "<leader>jb", "<cmd>JqxList boolean<CR>", desc = "Json Boolean List" },
            { "<leader>jq", "<cmd>JqxQuery<CR>", desc = "Json Query" },
        },
    },
}
