return {
    -- Manage projects
    {
        "telescope.nvim",
        dependencies = {
            {
                "ahmedkhalf/project.nvim",
                event = "VeryLazy",
                opts = {
                    manual_mode = true,
                },
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                    GionVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("projects")
                    end)
                end,
                keys = {
                    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
                },
            },
        },
    },
    -- Manage session
    {
        "folke/persistence.nvim",
        lazy = true,
        event = "BufReadPre",
        opts = {
            options = vim.opt.sessionoptions:get(),
        },
        keys = {
            {
                "<leader>qr",
                "<cmd>lua require('persistence').load()<CR>",
                desc = "Restore The Session For The Current Directory",
            },
            {
                "<leader>qt",
                "<cmd>lua require('persistence').load({ last = true })<CR>",
                desc = "Restore The Last Session",
            },
            {
                "<leader>qs",
                "<cmd>lua require('persistence').stop()<CR>",
                desc = "Session Won't Be Saved On Exit",
            },
        },
    },
}
