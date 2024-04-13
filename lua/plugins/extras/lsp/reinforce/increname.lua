return {
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<leader>iN", desc = "Rename (Not Retained Cursor Word)" },
            { "<leader>in", desc = "Rename (Reserve Cursor Word)" },
        },
        config = function()
            require("inc_rename").setup({
                preview_empty_name = true,
            })
            vim.keymap.set("n", "<leader>iN", ":IncRename ")
            vim.keymap.set("n", "<leader>in", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true })
        end,
    },
}
