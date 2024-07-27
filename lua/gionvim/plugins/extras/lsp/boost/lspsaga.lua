return {
    {
        "nvimdev/lspsaga.nvim",
        lazy = true,
        event = "LspAttach",
        keys = {
            -- callhierarchy
            { "<Leader>lgi", "<cmd>Lspsaga incoming_calls<CR>", desc = "Call Incoming" },
            { "<Leader>lgt", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Call Outgoing" },
            -- code action
            { "<leader>lga", "<cmd>Lspsaga code_action<CR>", desc = "Show Code Action" },
            -- definition
            { "<leader>lgf", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
            { "<leader>lgg", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto Definition" },
            { "<leader>lgy", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
            { "<leader>lgx", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Goto Type Definition" },
            -- diagnostics
            { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostics" },
            { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostics" },
            { "<leader>lgb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Show Buffer Diagnostics" },
            { "<leader>lgc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show Cursor Diagnostics" },
            { "<leader>lgl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show Line Diagnostics" },
            { "<leader>lgw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Show Workspace Diagnostics" },
            -- finder
            { "<leader>lgn", "<cmd>Lspsaga finder<CR>", desc = "Shows Results For References And Implementation" },
            -- hover
            { "<leader>lgh", "<cmd>Lspsaga hover_doc<CR>", desc = "Show Hover Doc" },
            { "<leader>lgk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Hover In Upper Right Corner" },
            -- outline
            { "<leader>lgo", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
            -- rename
            { "<leader>lgr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
            { "<leader>lgp", "<cmd>Lspsaga rename ++project<CR>", desc = "Rename LSP Integration" },
            { "<leader>lgs", ":Lspsaga project_replace", desc = "Project-wide Replace" },
            -- terminal
            { "<leader>lgm", "<cmd>Lspsaga term_toggle<CR>", desc = "Float Terminal" },
        },
        dependencies = { "nvim-treesitter" },
        config = function()
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = false,
                },
                code_action = {
                    num_shortcut = true,
                    show_server_name = true,
                    extend_gitsigns = true,
                },
            })
            -- 带过滤器的诊断跳转
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Prev Diagnostics ERROR" })
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end, { desc = "Next Diagnostics ERROR" })
            vim.keymap.set("n", "[W", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
            end, { desc = "Prev Diagnostics WARN" })
            vim.keymap.set("n", "]W", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
            end, { desc = "Next Diagnostics WARN" })
        end,
    },
}
