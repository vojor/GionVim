return {
    {
        "nvimdev/dashboard-nvim",
        lazy = false,
        opts = function()
            -- Generate character address
            -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=gionvim
            -- local logo = [[
            --     ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗            ▒█▒
            --     ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║         ▄▒▀  ▀▄
            --     ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║        ▄▒ ⢀⣄  ▒
            --     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║        █ ⠼⣁⠀⡱ █
            --     ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║       ██  ⠛⠻ ▒▒
            --     ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝       ▒▒    █▀█
            -- ]]

            local logo = [[
   ██████╗    ██╗    ██████╗    ███╗   ██╗   ██╗   ██╗  ██╗  ███╗   ███╗
  ██╔════╝    ██║   ██╔═══██╗   ████╗  ██║   ██║   ██║  ██║  ████╗ ████║
  ██║  ███╗   ██║   ██║   ██║   ██╔██╗ ██║   ██║   ██║  ██║  ██╔████╔██║
  ██║   ██║   ██║   ██║   ██║   ██║╚██╗██║   ╚██╗ ██╔╝  ██║  ██║╚██╔╝██║
  ╚██████╔╝   ██║   ╚██████╔╝   ██║ ╚████║    ╚████╔╝   ██║  ██║ ╚═╝ ██║
   ╚═════╝    ╚═╝    ╚═════╝    ╚═╝  ╚═══╝     ╚═══╝    ╚═╝  ╚═╝     ╚═╝
            ]]

            logo = string.rep("\n", 2) .. logo .. "\n\n"

            local opts = {
                theme = "doom",
                hide = {
                    statusline = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
                    center = {
                        {
                            action = "lua GionVim.pick()()",
                            desc = " Find File",
                            icon = " ",
                            key = "f",
                        },
                        {
                            action = "Telescope projects",
                            desc = " Find Projects",
                            icon = " ",
                            key = "p",
                        },
                        {
                            action = 'lua GionVim.pick("oldfiles")()',
                            desc = " Recent Files",
                            icon = " ",
                            key = "r",
                        },
                        {
                            action = "Telescope egrepify",
                            desc = " Find Text",
                            icon = " ",
                            key = "g",
                        },
                        {
                            action = "lua GionVim.pick.config_files()()",
                            desc = " Config",
                            icon = " ",
                            key = "c",
                        },
                        {
                            action = 'lua require("persistence").load()',
                            desc = " Restore Session",
                            icon = " ",
                            key = "s",
                        },
                        {
                            action = "Lazy",
                            desc = " Lazy",
                            icon = "󰒲 ",
                            key = "l",
                        },
                        {
                            action = function()
                                vim.api.nvim_input("<cmd>qa<cr>")
                            end,
                            desc = " Quit",
                            icon = " ",
                            key = "q",
                        },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return {
                            "⚡ Neovim loaded "
                                .. stats.loaded
                                .. "/"
                                .. stats.count
                                .. " plugins in "
                                .. ms
                                .. "ms"
                                .. " 😀😀😀",
                        }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
}
