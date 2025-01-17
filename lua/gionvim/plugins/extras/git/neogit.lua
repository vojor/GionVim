return {
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        keys = {
            { "<leader>gn", "", desc = "neogit" },
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
        dependencies = { { "plenary.nvim" }, { "diffview.nvim" } },
        opts = {
            integrations = {
                diffview = true,
            },
        },
    },
}
