return {
    -- Experimental beautification
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
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
            {
                "<leader>up",
                function()
                    require("noice").cmd("pick")
                end,
                desc = "Noice Pick Telescope/FzfLua",
            },
        },
        config = function(_, opts)
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
    },
    -- Scroll bar
    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPost", "BufNewFile" },
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
                    "noice",
                    "TelescopePrompt",
                    "dashboard",
                },
                handlers = {
                    gitsigns = true,
                    search = true,
                },
            })
        end,
    },
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=gionvim
                    header = [[
   ██████╗    ██╗    ██████╗    ███╗   ██╗   ██╗   ██╗  ██╗  ███╗   ███╗
  ██╔════╝    ██║   ██╔═══██╗   ████╗  ██║   ██║   ██║  ██║  ████╗ ████║
  ██║  ███╗   ██║   ██║   ██║   ██╔██╗ ██║   ██║   ██║  ██║  ██╔████╔██║
  ██║   ██║   ██║   ██║   ██║   ██║╚██╗██║   ╚██╗ ██╔╝  ██║  ██║╚██╔╝██║
  ╚██████╔╝   ██║   ╚██████╔╝   ██║ ╚████║    ╚████╔╝   ██║  ██║ ╚═╝ ██║
   ╚═════╝    ╚═╝    ╚═════╝    ╚═╝  ╚═══╝     ╚═══╝    ╚═╝  ╚═╝     ╚═╝
                    ]],
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":Telescope egrepify" },
                        { icon = " ", key = "p", desc = "Projects", action = ":Telescope projects" },

                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
            },
        },
    },
}
