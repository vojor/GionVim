return {
    {
        "stevearc/aerial.nvim",
        lazy = true,
        keys = {
            { "<leader>na", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
            { "<leader>nn", "<cmd>AerialNavToggle<CR>", desc = "Toggle Aerial Navigator" },
        },
        opts = function()
            local Config = require("config")
            local icons = vim.deepcopy(require("core.icons").icons.kinds)

            icons.lua = { Package = icons.Control }

            local filter_kind = false
            if Config.filter.kind_filter then
                filter_kind = assert(vim.deepcopy(Config.filter.kind_filter))
                filter_kind._ = filter_kind.default
                filter_kind.default = nil
            end
            local opts = {
                backends = { "lsp", "treesitter", "markdown", "man" },
                layout = {
                    min_width = 20,
                    win_opts = {
                        winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
                        signcolumn = "yes",
                        statuscolumn = " ",
                    },
                    default_direction = "prefer_left",
                },
                filter_kind = filter_kind,
                icons = icons,
                attach_mode = "global",
                show_guides = true,
                guides = {
                    mid_item = "├╴",
                    last_item = "└╴",
                    nested_top = "│ ",
                    whitespace = "  ",
                },
                highlight_on_hover = true,
                autojump = true,
                ignore = {
                    filetypes = {
                        "neo-tree",
                        "sagaoutline",
                        "qf",
                        "Trouble",
                        "trouble",
                        "spectre_panel",
                        "notify",
                        "noice",
                    },
                },
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "[a",
                        "<cmd>AerialPrev<CR>",
                        { buffer = bufnr, desc = "Goto Prev Aerial Symbol" }
                    )
                    vim.keymap.set(
                        "n",
                        "]a",
                        "<cmd>AerialNext<CR>",
                        { buffer = bufnr, desc = "Goto Next Aerial Symbol" }
                    )
                end,
            }
            return opts
        end,
    },
    -- aerial的telescope可选配置
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function()
            GionVim.on_load("telescope.nvim", function()
                require("telescope").load_extension("aerial")
            end)
        end,
        keys = {
            {
                "<leader>fa",
                "<cmd>Telescope aerial<cr>",
                desc = "Goto Symbol (Aerial)",
            },
        },
    },
}
