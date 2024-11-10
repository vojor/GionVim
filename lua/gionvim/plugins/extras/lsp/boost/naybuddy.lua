return {
    {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        keys = {
            { "<leader>ny", "<cmd>Navbuddy<CR>", desc = "Navbuddy Float Outline" },
        },
        dependencies = {
            {
                "SmiteshP/nvim-navic",
                lazy = true,
                init = function()
                    vim.g.navic_silence = true
                    GionVim.lsp.on_attach(function(client, buffer)
                        if client.supports_method("textDocument/documentSymbol") then
                            require("nvim-navic").attach(client, buffer)
                        end
                    end)
                end,
                opts = function()
                    return {
                        lsp = {
                            auto_attach = true,
                        },
                        separator = " ",
                        highlight = true,
                        depth_limit = 5,
                        icons = GionConfig.icons.kinds,
                        lazy_update_context = true,
                    }
                end,
            },
            { "nvim-lspconfig" },
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
