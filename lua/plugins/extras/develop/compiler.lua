return {
    -- 构建和运行代码
    {
        "Zeioth/compiler.nvim",
        lazy = true,
        keys = {
            { "<leader>epo", "<cmd>CompilerOpen<CR>", desc = "Open Compiler Face" },
            { "<leader>epr", "<cmd>CompilerToggleResults<CR>", desc = "Result Compiler" },
            { "<leader>epd", "<cmd>CompilerRedo<CR>", desc = "Redo Compiler" },
            { "<leader>eps", "<cmd>CompilerStop<CR>", desc = "Stop Compiler" },
        },
        dependencies = {
            {
                "stevearc/overseer.nvim",
                lazy = true,
                opts = {
                    task_list = {
                        direction = "bottom",
                        min_height = 25,
                        max_height = 25,
                        default_detail = 1,
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
        },
        opts = {},
    },
}
