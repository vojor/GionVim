return {
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        config = function()
            require("clangd_extensions").setup({
                ast = {
                    role_icons = {
                        type = "",
                        declaration = "",
                        expression = "",
                        specifier = "",
                        statement = "",
                        ["template argument"] = "",
                    },
                    kind_icons = {
                        Compound = "",
                        Recovery = "",
                        TranslationUnit = "",
                        PackExpansion = "",
                        TemplateTypeParm = "",
                        TemplateTemplateParm = "",
                        TemplateParamObject = "",
                    },
                },
                memory_usage = {
                    border = "rounded",
                },
                symbol_info = {
                    border = "single",
                },
            })
            vim.keymap.set("n", "<leader>jcs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Show Cursor Local Symbol Info" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>jcl", "<cmd>ClangdTypeHierarchy<CR>", { desc = "Show Cursor Local Type Hierarchy" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>jcg", "<cmd>ClangdMemoryUsage expand_preamble<CR>", { desc = "Show Memory Use Status" })
        end,
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<leader>jc"] = { name = "clangd" },
            },
        },
    },
}
