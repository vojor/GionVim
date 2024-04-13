--vim: ft=lua tw=120

stds.nvim = {
    read_globals = {
        "jit",
        "os",
        "env",
        "vim",
        "LabVim",
        "vim.o",
        "vim.g",
        "vim.b",
        "vim.w",
        "vim.go",
        "vim.bo",
        "vim.wo",
        "vim.opt",
        "vim.env",
    },
    globals = {
        vim = { fields = { "g" } },
        os = { fields = { "capture" } },
    },
}
std = "lua51+nvim"

self = false

cache = true

ignore = {
    "631",
    "212/_.*",
}
