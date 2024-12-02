local picker = {
    name = "telescope",
    commands = {
        files = "find_files",
    },
    open = function(builtin, opts)
        opts = opts or {}
        opts.follow = opts.follow ~= false
        if opts.cwd and opts.cwd ~= vim.uv.cwd() then
            local function open_cwd_dir()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                GionVim.pick.open(
                    builtin,
                    vim.tbl_deep_extend("force", {}, opts or {}, {
                        root = false,
                        default_text = line,
                    })
                )
            end
            opts.attach_mappings = function(_, map)
                map("i", "<m-c>", open_cwd_dir, { desc = "Open cwd Directory" })
                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end,
}
if not GionVim.pick.register(picker) then
    return {}
end
return {
    -- telescope fuzzy find
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                lazy = true,
                config = function(plugin)
                    GionVim.on_load("telescope.nvim", function()
                        local ok, err = pcall(require("telescope").load_extension, "fzf")
                        if not ok then
                            local lib = plugin.dir .. "/build/libfzf." .. (GionVim.is_win() and "dll" or "so")
                            if not vim.uv.fs_stat(lib) then
                                GionVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
                                require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                                    GionVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
                                end)
                            else
                                GionVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
                            end
                        end
                    end)
                end,
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                lazy = true,
                config = function()
                    GionVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("file_browser")
                    end)
                end,
            },
            {
                "fdschmidt93/telescope-egrepify.nvim",
                lazy = true,
                config = function()
                    GionVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("egrepify")
                    end)
                end,
            },
            { "plenary.nvim" },
        },
        opts = function()
            local actions = require("telescope.actions")
            local egrep_actions = require("telescope._extensions.egrepify.actions")

            local open_with_trouble = function(...)
                return require("trouble.sources.telescope").open(...)
            end

            local find_files_no_ignore = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                GionVim.pick("find_files", { no_ignore = true, default_text = line })()
            end
            local find_files_with_hidden = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                GionVim.pick("find_files", { hidden = true, default_text = line })()
            end

            local function find_command()
                if 1 == vim.fn.executable("rg") then
                    return { "rg", "--files", "--color", "never", "-g", "!.git" }
                elseif 1 == vim.fn.executable("fd") then
                    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("fdfind") then
                    return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
                    return { "find", ".", "-type", "f" }
                elseif 1 == vim.fn.executable("where") then
                    return { "where", "/r", ".", "*" }
                end
            end

            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    get_selection_window = function()
                        local wins = vim.api.nvim_list_wins()
                        table.insert(wins, 1, vim.api.nvim_get_current_win())
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].buftype == "" then
                                return win
                            end
                        end
                        return 0
                    end,
                    mappings = {
                        i = {
                            ["<M-w>"] = "which_key",
                            ["<M-t>"] = open_with_trouble,
                            ["<M-i>"] = find_files_no_ignore,
                            ["<M-h>"] = find_files_with_hidden,
                            ["<C-Down>"] = actions.cycle_history_next,
                            ["<C-Up>"] = actions.cycle_history_prev,
                            ["<C-F>"] = actions.preview_scrolling_down,
                            ["<C-B>"] = actions.preview_scrolling_up,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = find_command,
                        hidden = true,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    file_browser = {
                        hijack_netrw = true,
                    },
                    egrepify = {
                        AND = true,
                        permutations = false,
                        lnum = true,
                        lnum_hl = "EgrepifyLnum",
                        col = false,
                        col_hl = "EgrepifyCol",
                        title = true,
                        filename_hl = "EgrepifyFile",
                        prefixes = {
                            ["!"] = {
                                flag = "invert-match",
                            },
                            ["^"] = false,
                        },
                        mappings = {
                            i = {
                                ["<C-z>"] = egrep_actions.toggle_prefixes,
                                ["<C-a>"] = egrep_actions.toggle_and,
                                ["<C-r>"] = egrep_actions.toggle_permutations,
                            },
                        },
                    },
                },
            }
        end,
        keys = {
            {
                "<leader>fb",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true theme=ivy<cr>",
                desc = " Find Buffers",
            },
            { "<leader>fB", "<cmd>Telescope scope buffers<CR>", desc = "Find Scope buffers" },
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Find Commands" },
            { "<leader>fC", "<cmd>Telescope command_history<CR>", desc = "Find Command History" },
            -- stylua: ignore
            { "<leader>fd", GionVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
            { "<leader>fe", "<cmd>Telescope egrepify<CR>", desc = "Egrepify Live Grep" },
            { "<leader>ff", GionVim.pick("files"), desc = "Find Files (Root Dir)" },
            { "<leader>fF", GionVim.pick("files", { root = false }), desc = "Find Files (CWD)" },
            { "<leader>fg", GionVim.pick("live_grep"), desc = "Grep Text (Root Dir)" },
            { "<leader>fG", GionVim.pick("live_grep", { root = false }), desc = "Grep Text (CWD)" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help Tags" },
            { "<leader>fi", "<cmd>Telescope registers<CR>", desc = "Find Registers" },
            { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Find Marks" },
            { "<leader>fn", "<cmd>Telescope vim_options<cr>", desc = "Find Vim Options" },
            { "<leader>fr", GionVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
            { "<leader>ft", "<cmd>Telescope file_browser theme=ivy<CR>", desc = "Open File Tree" },
            -- stylua: ignore
            { "<leader>fT", "<cmd>Telescope file_browser path=%:p:h select_buffer=true theme=ivy<CR>", desc = "Open File Tree(CWD)" },
            { "<leader>sw", GionVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
            { "<leader>sW", GionVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
            {
                "<leader>fl",
                function()
                    require("telescope.builtin").lsp_document_symbols({
                        symbols = GionConfig.get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol",
            },
            {
                "<leader>fL",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols({
                        symbols = GionConfig.get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol (Workspace)",
            },
            {
                "<leader>fD",
                function()
                    require("telescope.builtin").lsp_definitions({ reuse_win = true })
                end,
                desc = "Goto Definition",
            },
            {
                "<leader>fy",
                function()
                    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
                end,
                desc = "Goto T[y]pe Definition",
            },
            {
                "<leader>fI",
                function()
                    require("telescope.builtin").lsp_implementations({ reuse_win = true })
                end,
                desc = "Goto Implementation",
            },
        },
    },
}
