if gionvim_docs then
    vim.g.gionvim_picker = "snacks"
end

local picker = {
    name = "snacks",
    commands = {
        files = "files",
        live_grep = "grep",
        oldfiles = "recent",
    },

    open = function(source, opts)
        return Snacks.picker.pick(source, opts)
    end,
}
if not GionVim.pick.register(picker) then
    return {}
end

return {
    recommended = true,
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<M-c>"] = {
                                "toggle_cwd",
                                mode = { "n", "i" },
                            },
                        },
                    },
                },
                actions = {
                    toggle_cwd = function(p)
                        local root = GionVim.root({ buf = p.input.filter.current_buf, normalize = true })
                        local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
                        local current = p:cwd()
                        p:set_cwd(current == root and cwd or root)
                        p:find()
                    end,
                },
            },
        },
        keys = {
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fJ",
                function()
                    Snacks.picker.buffers({ hidden = true, nofile = true })
                end,
                desc = "Buffers (ALL)",
            },
            {
                "<leader>fC",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>fN",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "Notifucations History",
            },
            { "<leader>fn", GionVim.pick.config_files(), desc = "Find Config File" },
            { "<leader>ff", GionVim.pick("files"), desc = "Find Files (Root Dir)" },
            { "<leader>fF", GionVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
            {
                "<leader>fg",
                function()
                    Snacks.picker.git_files()
                end,
                desc = "Find Files (git-files)",
            },
            { "<leader>fr", GionVim.pick("oldfiles"), desc = "Recent" },
            {
                "<leader>fR",
                function()
                    Snacks.picker.recent({ filter = { cwd = true } })
                end,
                desc = "Recent (cwd)",
            },
            -- git
            {
                "<leader>fL",
                function()
                    Snacks.picker.git_log()
                end,
                desc = "Git Log",
            },
            {
                "<leader>fd",
                function()
                    Snacks.picker.git_diff()
                end,
                desc = "Git Diff (hunks)",
            },
            {
                "<leader>fs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            {
                "<leader>fQ",
                function()
                    Snacks.picker.git_stash()
                end,
                desc = "Git Stash",
            },
            -- Grep
            {
                "<leader>fe",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Buffer Lines",
            },
            {
                "<leader>fB",
                function()
                    Snacks.picker.grep_buffers()
                end,
                desc = "Grep Open Buffers",
            },
            { "<leader>fg", GionVim.pick("live_grep"), desc = "Grep (Root Dir)" },
            { "<leader>fG", GionVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
            {
                "<leader>fw",
                GionVim.pick("grep_word"),
                desc = "Visual selection or word (Root Dir)",
                mode = { "n", "x" },
            },
            {
                "<leader>fW",
                GionVim.pick("grep_word", { root = false }),
                desc = "Visual selection or word (cwd)",
                mode = { "n", "x" },
            },
            {
                "<leader>fA",
                function()
                    Snacks.picker.lazy()
                end,
                desc = "Search Plugin Spec",
            },
            {
                "<leader>fi",
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<leader>fa",
                function()
                    Snacks.picker.autocmds()
                end,
                desc = "Autocmds",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>fC",
                function()
                    Snacks.picker.commands()
                end,
                desc = "Commands",
            },
            {
                "<leader>fD",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>fE",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>fh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>fH",
                function()
                    Snacks.picker.highlights()
                end,
                desc = "Highlights",
            },
            {
                "<leader>fj",
                function()
                    Snacks.picker.jumps()
                end,
                desc = "Jumps",
            },
            {
                "<leader>fk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>fl",
                function()
                    Snacks.picker.loclist()
                end,
                desc = "Location List",
            },
            {
                "<leader>fM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                "<leader>fm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Marks",
            },
            {
                "<leader>fI",
                function()
                    Snacks.picker.icons()
                end,
                desc = "Icons",
            },
            {
                "<leader>fu",
                function()
                    Snacks.picker.resume()
                end,
                desc = "Resume",
            },
            {
                "<leader>fq",
                function()
                    Snacks.picker.qflist()
                end,
                desc = "Quickfix List",
            },
            {
                "<leader>fo",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            {
                "<leader>fU",
                function()
                    Snacks.picker.undo()
                end,
                desc = "UndoTree",
            },
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Projects",
            },
            {
                "<leader>fS",
                function()
                    Snacks.picker.lsp_symbols({ filter = GionConfig.kind_filter })
                end,
                desc = "LSP Symbols",
            },
            {
                "<leader>ft",
                function()
                    Snacks.picker.lsp_workspace_symbols({ filter = GionConfig.kind_filter })
                end,
                desc = "Lsp Workspace Symbols",
            },
        },
    },
    {
        "folke/snacks.nvim",
        opts = function(_, opts)
            if GionVim.has("trouble.nvim") then
                return vim.tbl_deep_extend("force", opts or {}, {
                    picker = {
                        actions = {
                            trouble_open = function(...)
                                return require("trouble.sources.snacks").actions.trouble_open.action(...)
                            end,
                        },
                        win = {
                            input = {
                                keys = {
                                    ["<M-t>"] = {
                                        "trouble_open",
                                        mode = { "n", "i" },
                                    },
                                },
                            },
                        },
                    },
                })
            end
        end,
    },
    {
        "folke/flash.nvim",
        optional = true,
        specs = {
            {
                "folke/snacks.nvim",
                opts = {
                    picker = {
                        win = {
                            input = {
                                keys = {
                                    ["<a-s>"] = { "flash", mode = { "n", "i" } },
                                    ["s"] = { "flash" },
                                },
                            },
                        },
                        actions = {
                            flash = function(picker)
                                require("flash").jump({
                                    pattern = "^",
                                    label = { after = { 0, 0 } },
                                    search = {
                                        mode = "search",
                                        exclude = {
                                            function(win)
                                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                                                    ~= "snacks_picker_list"
                                            end,
                                        },
                                    },
                                    action = function(match)
                                        local idx = picker.list:row2idx(match.pos[1])
                                        picker.list:_move(idx, true, true)
                                    end,
                                })
                            end,
                        },
                    },
                },
            },
        },
    },
}
