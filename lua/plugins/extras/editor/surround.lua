return {
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            keymaps = {
                normal = "cm",
                normal_cur = "cmm",
                normal_line = "cM",
                normal_cur_line = "cMM",
                visual = "gs",
                visual_line = "gS",
                delete = "dn",
                change = "cn",
                change_line = "cN",
            },
        },
    },
}
