return {
    {
        "otavioschwanck/arrow.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            show_icons = true,
            leader_key = ".",
            buffer_leader_key = "q",
        },
    },
}
