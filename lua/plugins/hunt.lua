return {
    -- telescope 模糊查找
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
                config = function()
                    GionVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("fzf")
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
            {
                "nvim-telescope/telescope-ui-select.nvim",
                lazy = true,
                config = function()
                    GionVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("ui-select")
                    end)
                end,
            },
            { "plenary.nvim" },
        },
        opts = function()
            local actions = require("telescope.actions")
            local egrep_actions = require("telescope._extensions.egrepify.actions")

            local open_with_trouble = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
            end
            local open_selected_with_trouble = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end
            local find_files_no_ignore = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                GionVim.telescope("find_files", { no_ignore = true, default_text = line })()
            end
            local find_files_with_hidden = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                GionVim.telescope("find_files", { hidden = true, default_text = line })()
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
                            ["<M-a>"] = open_selected_with_trouble,
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
                pickers = {},
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
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
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
            -- stylua: ignore
            { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=ivy<CR>", desc = "Find Buffers" },
            { "<leader>fB", "<cmd>Telescope scope buffers<CR>", desc = "Find Scope buffers" },
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Find Commands" },
            { "<leader>fC", "<cmd>Telescope command_history<CR>", desc = "Find Command History" },
            -- stylua: ignore
            { "<leader>fd", GionVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
            { "<leader>fe", "<cmd>Telescope egrepify<CR>", desc = "Egrepify Live Grep" },
            { "<leader>ff", GionVim.telescope("files"), desc = "Find Files (Root Dir)" },
            { "<leader>fF", GionVim.telescope("files", { cwd = false }), desc = "Find Files (CWD)" },
            { "<leader>fg", GionVim.telescope("live_grep"), desc = "Grep Text (Root Dir)" },
            { "<leader>fG", GionVim.telescope("live_grep", { cwd = false }), desc = "Grep Text (CWD)" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help Tags" },
            { "<leader>fi", "<cmd>Telescope registers<CR>", desc = "Find Registers" },
            { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "Find Marks" },
            { "<leader>fn", "<cmd>Telescope vim_options<cr>", desc = "Find Vim Options" },
            { "<leader>fr", "<cmd>Telescope oldfiles theme=ivy<CR>", desc = "Find Old Files" },
            { "<leader>ft", "<cmd>Telescope file_browser theme=ivy<CR>", desc = "Open File Tree" },
            -- stylua: ignore
            { "<leader>fT", "<cmd>Telescope file_browser path=%:p:h select_buffer=true theme=ivy<CR>", desc = "Open File Tree(CWD)" },
            -- stylua: ignore
            { "<leader>fw", GionVim.telescope("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
            {
                "<leader>fl",
                function()
                    require("telescope.builtin").lsp_document_symbols({
                        symbols = require("config.norm").get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol",
            },
            {
                "<leader>fL",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols({
                        symbols = require("config.norm").get_kind_filter(),
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
