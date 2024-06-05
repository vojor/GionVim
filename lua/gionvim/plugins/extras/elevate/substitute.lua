return {

    {
        "chrisgrieser/nvim-rip-substitute",
        lazy = true,
        keys = {
            {
                "<leader>sr",
                function()
                    require("rip-substitute").sub()
                end,
                mode = { "n", "x" },
                desc = " rip substitute",
            },
        },
        dependencies = { "dressing.nvim" },
    },
}
