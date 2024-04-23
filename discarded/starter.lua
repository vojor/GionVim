return {
    {
        "echasnovski/mini.starter",
        version = false,
        event = "VimEnter",
        opts = function()
            local logo = table.concat({
                "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
            }, "\n")
            local pad = string.rep(" ", 0)
            local new_section = function(name, action, section)
                return { name = name, action = action, section = pad .. section }
            end

            local starter = require("mini.starter")
            local config = {
                evaluate_single = true,
                header = logo,
                items = {
                    new_section("Find file ", "Telescope find_files", "Inquiry"),
                    -- new_section("Recent files ", "Telescope oldfiles", "Inquiry"),
                    new_section("Grep text ", "Telescope live_grep", "Inquiry"),
                    new_section("Open last projects ", "Telescope projects", "Inquiry"),
                    new_section("MRU ", "Telescope frecency", "Inquiry"),
                    new_section("Browser ", "Telescope file_browser", "FileTree"),
                    -- new_section("Settings ", "e $MYVIMRC", "Config"),
                    new_section("Session ", "lua require('persistence').load()", "Session"),
                    new_section("Lazy 鈴", "Lazy", "Config"),
                    -- new_section("New file ", "ene | startinsert", "Built-in"),
                    new_section("Quit ", "qa", "Built-in"),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(pad .. "░ ", false),
                    starter.gen_hook.aligning("center", "center"),
                },
            }
            return config
        end,
        config = function(_, config)
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "MiniStarterOpened",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
            local starter = require("mini.starter")
            starter.setup(config)

            -- vim.api.nvim_create_autocmd("User", {
            --     pattern = "LazyVimStarted",
            --     callback = function()
            --         local stats = require("lazy").stats()
            --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            --         local pad_footer = string.rep(" ", 8)
            --         starter.config.footer = pad_footer
            --             .. "⚡ Neovim loaded "
            --             .. stats.count
            --             .. " plugins in "
            --             .. ms
            --             .. "ms"
            --         pcall(starter.refresh)
            --     end,
            -- })
        end,
    },
}
