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
                    local history = require("project_nvim.utils.history")
                    history.delete_project = function(project)
                        for k, v in pairs(history.recent_projects) do
                            if v == project.value then
                                history.recent_projects[k] = nil
                                return
                            end
                        end
                    end
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
        opts = {},
        keys = {
            { "<leader>q", "", desc = "session" },
            {
                "<leader>ql",
                "<cmd>lua require('persistence').load()<CR>",
                desc = "Restore The Session For The Current Directory",
            },
            {
                "<leader>qL",
                "<cmd>lua require('persistence').load({ last = true })<CR>",
                desc = "Restore The Last Session",
            },
            {
                "<leader>qt",
                "<cmd>lua require('persistence').stop()<CR>",
                desc = "Session Won't Be Saved On Exit",
            },
            {
                "<leader>qs",
                function()
                    require("persistence").select()
                end,
                desc = "Select Session",
            },
        },
    },
}
