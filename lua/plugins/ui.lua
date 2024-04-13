return {
    -- 高度实验性插件
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
            routes = {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        keys = {
            {
                "<S-Enter>",
                function()
                    require("noice").redirect(vim.fn.getcmdline())
                end,
                mode = "c",
                desc = "Redirect Cmdline",
            },
            {
                "<leader>ul",
                function()
                    require("noice").cmd("last")
                end,
                desc = "Noice Last Message",
            },
            {
                "<leader>uh",
                function()
                    require("noice").cmd("history")
                end,
                desc = "Noice History",
            },
            {
                "<leader>ua",
                function()
                    require("noice").cmd("all")
                end,
                desc = "Noice All",
            },
            {
                "<leader>ud",
                function()
                    require("noice").cmd("dismiss")
                end,
                desc = "Dismiss All",
            },
        },
    },
    -- 消息弹窗
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        keys = {
            {
                "<leader>uy",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss All Notifications",
            },
        },
        opts = {
            stages = "static",
            timeout = 4000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
        },
        init = function()
            if not GionVim.has("noice.nvim") then
                GionVim.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
    },
    -- 滚动条
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                -- if colorscheme not tokyonight,use custom color
                -- handle = { color = "#892E42" },
                -- marks = {
                --     Cursor = { color = "#FD5622" },
                --     Search = { color = "#FFC860" },
                --     Error = { color = "#FD6883" },
                --     Warn = { color = "#FFD886" },
                --     Info = { color = "#A9DC76" },
                --     Hint = { color = "#78DCE8" },
                --     Misc = { color = "#AB9DF2" },
                --     GitAdd = { color = "#E85236" },
                --     GitChange = { color = "#D89D80" },
                --     GitDelete = { color = "#AB56B5" },
                -- },

                handle = { color = "#892E42" },
                marks = {
                    Cursor = { color = "#FD5622" },
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                    GitAdd = { color = "#E85236" },
                    GitChange = { color = "#D89D80" },
                    GitDelete = { color = "#AB56B5" },
                },
                excluded_buftypes = { "terminal", "nofile", "prompt", "popup", "quickfix" },
                excluded_filetypes = {
                    "cmp_docs",
                    "cmp_menu",
                    "noice",
                    "notify",
                    "TelescopePrompt",
                    "alpha",
                    "dashboard",
                    "starter",
                },
                handlers = {
                    gitsigns = true,
                    search = true,
                },
            })
        end,
    },
}
