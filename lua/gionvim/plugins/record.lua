return {
    -- Structure notes、manage project and task, etc
    {
        "nvim-neorg/neorg",
        enabled = false, -- tree-sitter not norg
        version = "*",
        ft = "norg",
        cmd = "Neorg",
        dependencies = { "luarocks.nvim" },
        opts = {
            load = {
                ["core.defaults"] = {},
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
}
