return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = "Outline",
        keys = { { "<leader>no", "<cmd>Outline<CR>", desc = "Toggle Outline" } },
        opts = function()
            local defaults = require("outline.config").defaults
            local opts = {
                outline_window = {
                    show_numbers = true,
                },
                preview_window = {
                    open_hover_on_preview = true,
                },
                providers = {
                    priority = { "lsp", "markdown", "norg" },
                },
                symbols = {
                    icons = {},
                    filter = vim.deepcopy(GionVim.config.kind_filter),
                },
                keymaps = {
                    up_and_jump = "<up>",
                    down_and_jump = "<down>",
                },
            }

            for kind, symbol in pairs(defaults.symbols.icons) do
                opts.symbols.icons[kind] = {
                    icon = GionVim.config.icons.kinds[kind] or symbol.icon,
                    hl = symbol.hl,
                }
            end
            return opts
        end,
    },
}
