return {
    -- 缩进线
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            scope = { enabled = false },
            indent = {
                char = "│",
                tab_char = "│",
            },
            exclude = {
                filetypes = {
                    "aerial",
                    "alpha",
                    "checkhealth",
                    "dashboard",
                    "help",
                    "jqx",
                    "lazy",
                    "lazyterm",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "Outline",
                    "qf",
                    "sagaoutline",
                    "spectre_panel",
                    "starter",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                },
            },
        },
    },
    -- 可视化缩进范围
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "aerial",
                    "alpha",
                    "checkhealth",
                    "dashboard",
                    "help",
                    "jqx",
                    "lazy",
                    "lazyterm",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "Outline",
                    "qf",
                    "sagaoutline",
                    "spectre_panel",
                    "starter",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
