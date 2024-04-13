return {
    -- 分割/合并代码块
    {
        "Wansmer/treesj",
        lazy = true,
        keys = {
            { "<leader>og", "<cmd>TSJToggle<CR>", desc = "Toggle Node" },
        },
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
        end,
    },
}
