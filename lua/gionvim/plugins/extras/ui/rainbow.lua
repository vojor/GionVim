return {
    -- 彩虹括号
    {
        "HiPhish/rainbow-delimiters.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            require("rainbow-delimiters.setup").setup({
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                    javascript = "rainbow-delimiters-react",
                    -- tsx = "rainbow-parens",
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
