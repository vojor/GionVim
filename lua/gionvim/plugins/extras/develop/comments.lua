return {
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        lazy = true,
        cmd = "TodoTrouble",
        keys = {
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Prev Jump Todo",
            },
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next Jump Todo",
            },
            {
                "<leader>tdt",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo",
            },
            {
                "<leader>tdr",
                function()
                    Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Todo/Fix/Fixme",
            },
            { "<leader>tdd", ":TodoTrouble cwd=", desc = "List Directory Todo Tag" },
            { "<leader>tde", ":TodoTrouble keywords=", desc = "List Filter Todo Keyswords" },
            { "<leader>tdq", "<cmd>TodoQuickFix<CR>", desc = "Use QuickFix Show Todo Tag" },
            { "<leader>tdl", "<cmd>TodoLocList<CR>", desc = "Use Localist Show Todo Tag" },
        },
        dependencies = { "plenary.nvim" },
        opts = {
            keywords = {
                FIX = { icon = " ", color = "#DC2626", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "!" } },
                TODO = { icon = " ", color = "#10B981" },
                HACK = { icon = " ", color = "#7C3AED" },
                WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
                PERF = { icon = "󰅒 ", color = "#FC9868", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = "󰍨 ", color = "#2563EB", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "#FF00FF", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        },
    },
    {
        "danymat/neogen",
        lazy = true,
        dependencies = GionVim.has("mini.snippets") and { "mini.snippets" } or {},
        cmd = "Neogen",
        keys = {
            { "<leader>ef", "<cmd>Neogen func<CR>", desc = "Generate Function Comment" },
            { "<leader>ec", "<cmd>Neogen class<CR>", desc = "Generate Class Comment" },
            { "<leader>et", "<cmd>Neogen type<CR>", desc = "Generate Type Comment" },
            { "<leader>ei", "<cmd>Neogen file<CR>", desc = "Generate File Comment" },
        },
        opts = function(_, opts)
            if opts.snippet_engine ~= nil then
                return
            end

            local map = {
                ["mini.snippets"] = "mini",
            }

            for plugin, engine in pairs(map) do
                if GionVim.has(plugin) then
                    opts.snippet_engine = engine
                    return
                end
            end

            if vim.snippet then
                opts.snippet_engine = "nvim"
            end
        end,
    },
}
