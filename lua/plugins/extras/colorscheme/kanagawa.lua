return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                functionStyle = { bold = true },
                keywordStyle = { bold = true, italic = false },
                statementStyle = { bold = true, italic = true },
                dimInactive = true,
            })
            require("kanagawa").load()
        end,
    },
}
