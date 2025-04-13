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
                memory_usage = { border = "rounded" },
                symbol_info = { border = "single" },
            })
            vim.keymap.set("n", "<leader>scs", "<cmd>ClangdSymbolInfo<CR>", { desc = "Symbol Info" })
            vim.keymap.set("n", "<leader>sca", "<cmd>ClangdAST<CR>", { desc = "AST Status" })
            vim.keymap.set("n", "<leader>scl", "<cmd>ClangdTypeHierarchy<CR>", { desc = "Type Hierarchy" })
            vim.keymap.set("n", "<leader>scg", "<cmd>ClangdMemoryUsage expand_preamble<CR>", { desc = "Memory Status" })
        end,
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            spec = { {
                { "<leader>sc", group = "clangd" },
            } },
        },
    },
}
