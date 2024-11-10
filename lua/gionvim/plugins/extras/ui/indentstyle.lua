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
                        "dashboard",
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
                    "dashboard",
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
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
