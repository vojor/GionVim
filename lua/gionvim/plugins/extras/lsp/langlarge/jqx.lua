return {
    -- json,yaml
    {
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        ft = { "json", "yaml" },
        cmd = { "JqxList", "JqxQuery" },
        keys = {
            { "<leader>sl", ":JqxList ", desc = "Jqx List Select", ft = { "json", "yaml" } },
            { "<leader>sq", ":JqxQuery ", desc = "Jqx Query Select", ft = { "json", "yaml" } },
        },
    },
}
