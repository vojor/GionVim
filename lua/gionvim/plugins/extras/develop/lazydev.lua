return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "GionVim", words = { "GionVim" } },
                { path = "lazy.nvim", words = { "GionVim" } },
            },
        },
    },
}
