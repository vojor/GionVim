return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = true,
        cmd = "RenderMarkdown",
        ft = { "markdown", "rmd", "norg" },
        opts = {
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            latex = { enabled = false },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            Snacks.toggle({
                name = "Render Markdown",
                get = function()
                    return require("render-markdown.state").enabled
                end,
                set = function(enabled)
                    local m = require("render-markdown")
                    if enabled then
                        m.enable()
                    else
                        m.disable()
                    end
                end,
            }):map("<leader>um")
        end,
    },
}
