return {
    {
        "folke/trouble.nvim",
        branch = "dev",
        lazy = true,
        cmd = "Trouble",
        keys = {
            { "<leader>xg", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
            { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>xd", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            {
                "<leader>xn",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[Q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
        },
        opts = {
            auto_preview = false,
            preview = { type = "float" },
            keys = {
                j = "next",
                k = "prev",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            local symbols = require("trouble").statusline({
                mode = "symbols",
                groups = {},
                title = false,
                filter = { range = true },
                format = "{kind_icon}{symbol.name:Normal}",
            })
            table.insert(opts.sections.lualine_c, {
                symbols.get,
                cond = symbols.has,
            })
        end,
    },
    {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
            for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
                opts[pos] = opts[pos] or {}
                table.insert(opts[pos], {
                    ft = "trouble",
                    filter = function(_buf, win)
                        return vim.w[win].trouble
                            and vim.w[win].trouble.position == pos
                            and vim.w[win].trouble.type == "split"
                            and vim.w[win].trouble.relative == "editor"
                            and not vim.w[win].trouble_preview
                    end,
                })
            end
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function(_, opts)
            local open_with_trouble = require("trouble.sources.telescope").open
            return vim.tbl_deep_extend("force", opts, {
                defaults = {
                    mappings = {
                        i = {
                            ["<M-t>"] = open_with_trouble,
                        },
                    },
                },
            })
        end,
    },
}
