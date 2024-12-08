return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            Snacks.toggle({
                name = "Indentation Guides",
                get = function()
                    return require("ibl.config").get_config(0).enabled
                end,
                set = function(state)
                    require("ibl").setup_buffer(0, { enabled = state })
                end,
            }):map("<leader>ug")

            return {
                indent = {
                    char = "│",
                    tab_char = "│",
                },
                scope = { show_start = false, show_end = false },
                exclude = {
                    filetypes = {
                        "checkhealth",
                        "jqx",
                        "help",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "lspinfo",
                        "grug-far",
                        "mason",
                        "notify",
                        "toggleterm",
                        "Outline",
                        "qf",
                        "sagaoutline",
                        "snacks_notif",
                        "snacks_terminal",
                        "snacks_win",
                        "snacks_dashboard",
                    },
                },
            }
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
                    "checkhealth",
                    "help",
                    "jqx",
                    "lazy",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "Outline",
                    "qf",
                    "grug-far",
                    "sagaoutline",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                    "snacks_notif",
                    "snacks_terminal",
                    "snacks_win",
                    "snacks_dashboard",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "SnacksDashboardOpened",
                callback = function(data)
                    vim.b[data.buf].miniindentscope_disable = true
                end,
            })
        end,
    },
}
