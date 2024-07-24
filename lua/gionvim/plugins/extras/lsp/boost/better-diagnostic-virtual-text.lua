return {
    {
        "sontungexpt/better-diagnostic-virtual-text",
        lazy = true,
        event = "LspAttach",
        config = function()
            require("better-diagnostic-virtual-text").setup()
        end,
    },
}
