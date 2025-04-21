return {
    {
        "stevearc/overseer.nvim",
        lazy = true,
        keys = {
            { "<leader>epw", "<cmd>OverseerToggle<cr>", desc = "Task list" },
            { "<leader>eps", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
            { "<leader>epl", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
            { "<leader>epd", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
            { "<leader>epr", "<cmd>OverseerRunCmd<cr>", desc = "Run CMD" },
            { "<leader>epo", "<cmd>OverseerRun<cr>", desc = "Run task" },
            { "<leader>epq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
            { "<leader>epi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
            { "<leader>epb", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
            { "<leader>ept", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
            { "<leader>epc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
        },
        opts = {
            dap = false,
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
                bindings = {
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                },
            },
            form = {
                win_opts = {
                    winblend = 0,
                },
            },
            confirm = {
                win_opts = {
                    winblend = 0,
                },
            },
            task_win = {
                win_opts = {
                    winblend = 0,
                },
            },
            log = {
                {
                    type = "notify",
                    level = vim.log.levels.ERROR,
                },
                {
                    type = "file",
                    filename = "overseer.log",
                    level = vim.log.levels.ERROR,
                },
            },
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
