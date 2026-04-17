vim.filetype.add({
    extension = {
        ["rasi"] = "rasi",
        ["rofi"] = "rasi",
        ["wofi"] = "rasi",
        ["http"] = "http",
    },
    filename = {
        ["vifmrc"] = "vim",
        [".autocorrectrc"] = "yaml",
        [".gersemirc"] = "yaml",
    },
    pattern = {
        ["%.env%.[%w_.-]+"] = "sh",
    },
})
