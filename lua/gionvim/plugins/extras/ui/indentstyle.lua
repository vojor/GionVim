return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                scope = { enabled = false },
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                exclude = {
                    filetypes = {
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
            })
        end,
    },
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
