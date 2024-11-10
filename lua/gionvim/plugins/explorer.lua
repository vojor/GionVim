return {
    -- File content
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = true,
        cmd = "Neotree",
        keys = {
            {
                "<leader>ng",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = GionVim.root() })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
            {
                "<leader>nG",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (CWD)",
            },
            {
                "<leader>ne",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git explorer",
            },
            {
                "<leader>nb",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer explorer",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
                desc = "Start Neo-tree with directory",
                once = true,
                callback = function()
                    if package.loaded["neo-tree"] then
                        return
                    else
                        local stats = vim.uv.fs_stat(vim.fn.argv(0))
                        if stats and stats.type == "directory" then
                            require("neo-tree")
                        end
                    end
                end,
            })
        end,
        dependencies = { { "plenary.nvim" }, { "nui.nvim" } },
        opts = {
            sources = { "filesystem", "buffers", "git_status" },
            open_files_do_not_replace_types = {
                "terminal",
                "toggleterm",
                "Trouble",
                "trouble",
                "qf",
                "Outline",
                "lazyterm",
            },
            default_component_configs = {
                indent = {
                    with_expander = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                git_status = {
                    symbols = {
                        unstaged = "󰄱",
                        staged = "󰱒",
                    },
                },
            },
            window = {
                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["<space>"] = "none",
                    ["Y"] = {
                        function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg("+", path, "c")
                        end,
                        desc = "Copy Path to Clipboard",
                    },
                    ["O"] = {
                        function(state)
                            require("lazy.util").open(state.tree:get_node().path, { system = true })
                        end,
                        desc = "open with system application",
                    },
                    ["P"] = { "toggle_preview", config = { use_float = false } },
                },
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enable = true },
                use_libuv_file_watcher = true,
                -- filtered_items = {
                --     hide_dotfiles = false,
                --     hide_gitignored = true,
                --     hide_by_name = { ".git" },
                -- },
            },
            source_selector = {
                winbar = true,
                statusline = true,
            },
        },
        config = function(_, opts)
            local function on_move(data)
                Snacks.rename.on_rename_file(data.source, data.destination)
            end

            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
}
