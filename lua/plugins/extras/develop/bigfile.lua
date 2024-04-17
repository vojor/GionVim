return {
    {
        "LunarVim/bigfile.nvim",
        lazy = true,
        event = { "BufReadPre" },
        opts = {
            filesize = 2,
            pattern = { "*" },
            features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        },
    },
}
