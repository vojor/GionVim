return {
    {
        "hasansujon786/nvim-navbuddy",
        lazy = true,
        keys = { { "<leader>ny", "<cmd>Navbuddy<CR>", desc = "Navbuddy Float Outline" } },
        dependencies = {
            {
                "SmiteshP/nvim-navic",
                lazy = true,
                init = function()
                    vim.g.navic_silence = true
                end,
                opts = function()
                    return {
                        lsp = {
                            auto_attach = true,
                        },
                        separator = " ",
                        highlight = true,
                        depth_limit = 5,
                        icons = GionVim.config.icons.kinds,
                        lazy_update_context = true,
                    }
                end,
            },
        },
        opts = {
            window = {
                border = "rounded",
            },
            lsp = {
                auto_attach = true,
            },
        },
    },
}
