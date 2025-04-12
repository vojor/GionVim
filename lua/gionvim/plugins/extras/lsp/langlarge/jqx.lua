return {
    -- json,yaml
    {
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        ft = { "json", "yaml" },
        cmd = { "JqxList", "JqxQuery" },
        keys = {
            { "<leader>sl", ":JqxList ", desc = "Jqx List Select" },
            { "<leader>sq", ":JqxQuery ", desc = "Jqx Query Select" },
        },
    },
}
