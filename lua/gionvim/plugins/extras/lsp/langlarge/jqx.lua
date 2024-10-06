return {
    -- json,yaml
    {
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        ft = { "json", "yaml" },
        cmd = { "JqxList", "JqxQuery" },
        keys = {
            { "<leader>jl", "<cmd>JqxList<CR>", desc = "Json List" },
            { "<leader>jn", ":JqxList ", desc = "Jqx Select" },
            { "<leader>jq", "<cmd>JqxQuery<CR>", desc = "Json Query" },
        },
    },
}
