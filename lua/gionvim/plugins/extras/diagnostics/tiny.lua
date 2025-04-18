return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        lazy = true,
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                options = {
                    use_icons_from_diagnostic = true,
                    set_arrow_to_diag_color = true,
                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                    format = function(diagnostic)
                        return diagnostic.message .. " [ " .. diagnostic.source .. "]"
                    end,
                },
                disabled_ft = { "make", "cmake" },
            })
        end,
    },
}
