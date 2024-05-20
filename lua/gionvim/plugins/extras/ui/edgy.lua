return {
    -- 预定义窗口布局
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>ue",
                function()
                    require("edgy").toggle()
                end,
                desc = "Toggle Edgy",
            },
            {
                "<leader>uE",
                function()
                    require("edgy").select()
                end,
                desc = "Edgy Select Window",
            },
        },
        opts = function()
            local opts = {
                bottom = {
                    {
                        ft = "toggleterm",
                        size = { height = 0.4 },
                        filter = function(buf, win)
                            return vim.api.nvim_win_get_config(win).relative == ""
                        end,
                    },
                    {
                        ft = "noice",
                        size = { height = 0.4 },
                        filter = function(buf, win)
                            return vim.api.nvim_win_get_config(win).relative == ""
                        end,
                    },
                    {
                        ft = "lazyterm",
                        title = "LazyTerm",
                        size = { height = 0.4 },
                        filter = function(buf)
                            return not vim.b[buf].lazyterm_cmd
                        end,
                    },
                    "Trouble",
                    { ft = "qf", title = "QuickFix" },
                    {
                        ft = "help",
                        size = { height = 20 },
                        filter = function(buf)
                            return vim.bo[buf].buftype == "help"
                        end,
                    },
                    { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
                },
                left = {
                    {
                        title = "Neo-Tree",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "filesystem"
                        end,
                        pinned = true,
                        open = function()
                            require("neo-tree.command").execute({ dir = GionVim.root() })
                        end,
                        size = { height = 0.5 },
                    },
                    {
                        title = "Neo-Tree Git",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "git_status"
                        end,
                        pinned = true,
                        open = "Neotree position=right git_status",
                    },
                    {
                        title = "Neo-Tree Buffers",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "buffers"
                        end,
                        pinned = true,
                        open = "Neotree position=top buffers",
                    },
                    {
                        title = "Neo-Tree Symbols",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "document_symbols"
                        end,
                        pinned = true,
                        open = "Neotree document_symbols",
                    },
                    "neo-tree",
                    {
                        title = "Aerial",
                        ft = "aerial",
                        pinned = true,
                        open = "AerialOpen",
                    },
                },
                right = {
                    {
                        title = "Outline",
                        ft = "Outline",
                        pinned = true,
                        open = "Outline",
                    },
                },
                keys = {
                    -- increase width
                    ["<C-Right>"] = function(win)
                        win:resize("width", 2)
                    end,
                    -- decrease width
                    ["<C-Left>"] = function(win)
                        win:resize("width", -2)
                    end,
                    -- increase height
                    ["<C-Up>"] = function(win)
                        win:resize("height", 2)
                    end,
                    -- decrease height
                    ["<C-Down>"] = function(win)
                        win:resize("height", -2)
                    end,
                },
            }
            return opts
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = {
            defaults = {
                get_selection_window = function()
                    require("edgy").goto_main()
                    return 0
                end,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        optional = true,
        opts = function(_, opts)
            opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
                or { "Outline", "terminal", "Trouble", "trouble", "qf" }
            table.insert(opts.open_files_do_not_replace_types, "edgy")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function()
            local Offset = require("bufferline.offset")
            if not Offset.edgy then
                local get = Offset.get
                Offset.get = function()
                    if package.loaded.edgy then
                        local layout = require("edgy.config").layout
                        local ret = { left = "", left_size = 0, right = "", right_size = 0 }
                        for _, pos in ipairs({ "left", "right" }) do
                            local sb = layout[pos]
                            if sb and #sb.wins > 0 then
                                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                                ret[pos .. "_size"] = sb.bounds.width
                            end
                        end
                        ret.total_size = ret.left_size + ret.right_size
                        if ret.total_size > 0 then
                            return ret
                        end
                    end
                    return get()
                end
                Offset.edgy = true
            end
        end,
    },
}
