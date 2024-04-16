return {
    -- 自动保存
    {
        "okuuva/auto-save.nvim",
        event = { "InsertLeave", "TextChanged" },
        keys = {
            { "<leader>oa", "<cmd>ASToggle<CR>", desc = "Toggle Auto Save" },
        },
        opts = {
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")
                local exclude_filetypes = {
                    "aerial",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "noice",
                    "notify",
                    "NeogitStatus",
                    "Outline",
                    "qf",
                    "sagaoutline",
                    "spectre_panel",
                    "starter",
                    "trouble",
                    "Trouble",
                }

                -- 不保存指定文件类型
                if utils.not_in(fn.getbufvar(buf, "&filetype"), exclude_filetypes) then
                    return true
                end
                return false
            end,
        },
    },
    -- 自动恢复光标位置
    {
        "vladdoster/remember.nvim",
        lazy = true,
        event = "BufReadPost",
        opts = {
            ignore_buftype = {
                "acwrite",
                "quickfix",
                "nofile",
                "nowrite",
                "help",
                "terminal",
                "popup",
                "main",
                "prompt",
            },
            ignore_filetype = {
                "aerial",
                "alpha",
                "dashboard",
                "gitcommit",
                "gitrebase",
                "hgcommit",
                "lazy",
                "neo-tree",
                "spectre_panel",
                "starter",
                "svn",
            },
            open_folds = true,
        },
    },
    -- 自动匹配括号
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup({
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
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
                    pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub("%s+", ""),
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
