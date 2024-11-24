return {

    {
        "chrisgrieser/nvim-rip-substitute",
        lazy = true,
        cmd = "RipSubstitute",
        keys = {
            {
                "<leader>rp",
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
