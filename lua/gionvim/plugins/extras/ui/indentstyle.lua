return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            GionVim.toggle.map("<leader>ug", {
                name = "Indention Guides",
                get = function()
                    return require("ibl.config").get_config(0).enabled
                end,
                set = function(state)
                    require("ibl").setup_buffer(0, { enabled = state })
                end,
            })

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
                        "alpha",
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
                        "lazyterm",
                        "sagaoutline",
                        "spectre_panel",
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
