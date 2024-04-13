return {
    {
        "rmehri01/onenord.nvim",
        priority = 1000,
        config = function()
            require("onenord").setup({
                theme = "dark",
                fade_nc = true,
                styles = {
                    comments = "italic",
                    strings = "bold",
                    keywords = "bold",
                    functions = "bold,italic",
                    variables = "bold",
                    diagnostics = "underline",
                },
            })
        end,
    },
}
