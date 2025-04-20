return {
    {
        "HiPhish/rainbow-delimiters.nvim",
        lazy = true,
        event = "LazyFile",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                    html = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                    javascript = "rainbow-delimiters-react",
                    typescript = "rainbow-parens",
                    query = function(bufnr)
                        local is_nofile = vim.bo[bufnr].buftype == "nofile"
                        return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
                    end,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            })
        end,
    },
}
