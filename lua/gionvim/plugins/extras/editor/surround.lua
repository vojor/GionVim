return {
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = true,
        event = "LazyFile",
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "gs",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
        },
    },
}
