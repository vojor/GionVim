return {
    -- neovim的magit
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        keys = {
            {
                "<leader>gnn",
                function()
                    require("neogit").open()
                end,
                desc = "Open Neoget Tab Page",
            },
            {
                "<leader>gnc",
                function()
                    require("neogit").open({ "commit" })
                end,
                desc = "Open Neogit Commit Page",
            },
            {
                "<leader>gnd",
                function()
                    require("neogit").open({ cwd = "%:p:h" })
                end,
                desc = "Open Neoget Current Repository",
            },
            {
                "<leader>gnt",
                function()
                    require("neogit").open({ kind = "tab" })
                end,
                desc = "Open Neogit Tab Popup",
            },
            {
                "<leader>gnr",
                function()
                    require("neogit").open({ kind = "replace" })
                end,
                desc = "Open Neogit Replace Popup",
            },
            {
                "<leader>gnf",
                function()
                    require("neogit").open({ kind = "floating" })
                end,
                desc = "Open Neogit Float Popup",
            },
            {
                "<leader>gns",
                function()
                    require("neogit").open({ kind = "split" })
                end,
                desc = "Open Neogit Split Popup",
            },
            {
                "<leader>gnb",
                function()
                    require("neogit").open({ kind = "split_above" })
                end,
                desc = "Open Neogit Split Above  Popup",
            },
            {
                "<leader>gnv",
                function()
                    require("neogit").open({ kind = "vsplit" })
                end,
                desc = "Open Neogit VSplit Popup",
            },
            {
                "<leader>gna",
                function()
                    require("neogit").open({ kind = "auto" })
                end,
                desc = "Open Neogit Auto Popup",
            },
        },
        dependencies = {
            { "plenary.nvim" },
            { "diffview.nvim" },
            { "telescope.nvim" },
        },
        opts = {
            integrations = {
                telescope = true,
                diffview = true,
            },
        },
    },
    -- 环浏览任何 git 版本的所有修改文件的差异
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>dvp", "<cmd>DiffviewOpen<CR>", desc = "Open New Diffview " },
            { "<leader>dvc", "<cmd>DiffviewClose<CR>", desc = "Close Current Diffview " },
            { "<leader>dvh", "<cmd>DiffviewFileHistory<CR>", desc = "View Files History Diff" },
            { "<leader>dvt", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle File Diff Panel" },
            { "<leader>dvr", "<cmd>DiffviewRefresh<CR>", desc = "Update Current Entries And File List" },
            { "<leader>dvu", "<cmd>DiffviewFocusFiles<CR>", desc = "Bring Focus To The File Panel" },
        },
        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
            })
        end,
    },
}
