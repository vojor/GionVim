return {
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            providers = { "lsp", "treesitter" },
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp", "treesitter" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            vim.keymap.set("n", "[l", function()
                require("illuminate").goto_prev_reference()
            end, { desc = "Prev Match Word" })
            vim.keymap.set("n", "]l", function()
                require("illuminate").goto_next_reference()
            end, { desc = "Next Match Word" })
        end,
        keys = {
            { "<leader>hi", "<cmd>IlluminateToggle<CR>", desc = "Toggle Overall Word Illuminate" },
            { "<leader>hb", "<cmd>IlluminateToggleBuf<CR>", desc = "Toggle Local Buffer Word Illuminate" },
        },
    },
}
