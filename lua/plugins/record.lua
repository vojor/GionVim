-- 笔记和任务清单
return {
    -- 结构化笔记、项目和任务管理、时间跟踪、幻灯片、编写排版文档
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        version = "*",
        ft = "norg",
        cmd = "Neorg",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Notes",
                        },
                    },
                },
                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.unmap("norg", "n", "<CR>")

                            keybinds.unmap("presenter", "n", "l")
                            keybinds.unmap("presenter", "n", "h")
                            keybinds.unmap("presenter", "n", "<CR>")
                            keybinds.unmap("presenter", "n", "q")

                            -- Unmaps any Neorg key from the `norg` mode
                            keybinds.remap_event("presenter", "n", "<Right>", "core.presenter.next_page")
                            keybinds.remap_event("presenter", "n", "<C-j>", "core.presenter.next_page")
                            keybinds.remap_event("presenter", "n", "<Left>", "core.presenter.previous_page")
                            keybinds.remap_event("presenter", "n", "<C-k>", "core.presenter.previous_page")
                            keybinds.remap_event("presenter", "n", "<Down>", "core.presenter.close")
                            keybinds.map("norg", "n", "<Up>", "<CMD>Neorg presenter start<CR>")
                        end,
                    },
                },
            },
        },
    },
    -- 处理 markdown,zettelkasten,wiki
    {
        "renerocksai/telekasten.nvim",
        lazy = true,
        cmd = "Telekasten",
        keys = {
            { "<leader>ea", "<cmd>Telekasten panel<CR>", desc = "Open Telekasten Commands Panel" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            home = vim.fn.expand("~/Notes/zettelkasten"),
        },
    },
}
