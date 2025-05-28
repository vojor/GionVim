return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        lazy = true,
        event = "LspAttach",
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
                disabled_ft = { "make", "cmake", "toml" },
            })
        end,
    },
    {
        "rachartier/tiny-code-action.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            backend = "delta",
            picker = { "snacks" },
        },
        config = function(_, opts)
            require("tiny-code-action").setup(opts)
            vim.keymap.set("n", "<leader>lc", function()
                require("tiny-code-action").code_action()
            end, { noremap = true, silent = true, desc = "Tiny Code Action" })
        end,
    },
}
