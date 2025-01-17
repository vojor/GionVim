return {
    {
        "okuuva/auto-save.nvim",
        lazy = true,
        event = { "InsertLeave", "TextChanged" },
        keys = {
            { "<leader>oa", "<cmd>ASToggle<CR>", desc = "Toggle Auto Save" },
        },
        opts = {
            condition = function(buf)
                local utils = require("auto-save.utils.data")
                local exclude_filetypes = {
                    "neo-tree",
                    "noice",
                    "notify",
                    "NeogitStatus",
                    "Outline",
                    "qf",
                    "sagaoutline",
                    "trouble",
                    "Trouble",
                    "grug-far",
                    "lazy",
                    "mason",
                    "lspinfo",
                }

                -- Not save designate file types
                if utils.not_in(vim.fn.getbufvar(buf, "&filetype"), exclude_filetypes) then
                    return true
                end
                return false
            end,
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup({
                disable_filetype = { "grug-far", "snacks_picker_input" },
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    typescript = { "template_string" },
                },
                enable_check_bracket_line = false,
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0,
                    end_key = "$",
                    before_key = "h",
                    after_key = "l",
                    cursor_pos_before = true,
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })
            local ts_conds = require("nvim-autopairs.ts-conds")
            npairs.add_rules({
                Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
                Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
            })
        end,
    },
}
