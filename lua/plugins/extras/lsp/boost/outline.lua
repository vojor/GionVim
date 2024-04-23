return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        keys = {
            { "<leader>no", "<cmd>Outline<CR>", desc = "Toggle Outline" },
        },
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
                symbols = {},
                symbol_blacklist = {},
            }
            local filter = require("config.accredit").kind_filter

            if type(filter) == "table" then
                filter = filter.default
                if type(filter) == "table" then
                    for kind, symbol in pairs(defaults.symbols) do
                        opts.symbols[kind] = {
                            icon = require("config.accredit").icons.kinds[kind] or symbol.icon,
                            hl = symbol.hl,
                        }
                        if not vim.tbl_contains(filter, kind) then
                            table.insert(opts.symbol_blacklist, kind)
                        end
                    end
                end
            end
            return opts
        end,
    },
}
