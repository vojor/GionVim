return {
    {
        "stevearc/overseer.nvim",
        keys = {
            { "<leader>p", "", desc = "task" },
            { "<leader>pw", "<cmd>OverseerToggle<cr>", desc = "Task list" },
            { "<leader>po", "<cmd>OverseerRun<cr>", desc = "Run task" },
            { "<leader>pt", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
        },
        opts = {
            dap = false,
            task_list = {
                keymaps = {
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                },
            },
            form = {
                win_opts = {
                    winblend = 0,
                },
            },
            task_win = {
                win_opts = {
                    winblend = 0,
                },
            },
            log_level = vim.log.levels.ERROR,
        },
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        opts = function()
            require("overseer").enable_dap()
        end,
    },
}
