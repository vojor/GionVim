return {
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        keys = {
            { "<leader>rn", desc = "Rename (Reserve Cursor Word)" },
            { "<leader>rN", desc = "Rename (Not Retained Cursor Word)" },
        },
        opts = {
            preview_empty_name = true,
        },
        config = function(_, opts)
            require("inc_rename").setup(opts)
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true })
            vim.keymap.set("n", "<leader>rN", ":IncRename ")
        end,
    },
}
