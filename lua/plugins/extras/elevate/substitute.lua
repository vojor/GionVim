return {

    {
        "chrisgrieser/nvim-alt-substitute",
        lazy = true,
        keys = {
            { "<leader>sa", mode = { "n", "x" }, desc = "󱗘 :AltSubstitute" },
            { "<leader>sA", mode = { "n", "x" }, desc = "󱗘 :AltSubstitute (word under cursor)" },
        },
        dependencies = { "dressing.nvim" },
        config = function()
            require("alt-substitute").setup()
            vim.keymap.set({ "n", "x" }, "<leader>sa", [[:S ///g<Left><Left><Left>]])
            vim.keymap.set({ "n", "x" }, "<leader>sA", function()
                return ":S /" .. vim.fn.expand("<cword>") .. "//g<Left><Left>"
            end, { expr = true })
        end,
    },
}
