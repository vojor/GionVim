return {
    -- Function or method end, Trail virtual text
    {
        "andersevenrud/nvim_context_vt",
        lazy = true,
        ft = { "c", "cpp", "lua", "python", "typescript", "javascript", "typescriptreact", "javascriptreact" },
        opts = {
            prefix = "",
            disable_virtual_lines_ft = { "yaml", "toml" },
        },
        config = function(_, opts)
            require("nvim_context_vt").setup(opts)
            vim.keymap.set("n", "<leader>ov", "<cmd>NvimContextVtToggle<CR>", { desc = "Toggle Trail Virtual Text" })
        end,
    },
    -- Exhibit function head
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = "LazyFile",
        keys = {
            {
                "[x",
                function()
                    require("treesitter-context").go_to_context()
                end,
                desc = "Goto Function/Method Head",
            },
        },
        opts = function()
            local tsc = require("treesitter-context")

            Snacks.toggle({
                name = "Treesitter Context",
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            }):map("<leader>ut")

            return { mode = "cursor", max_lines = 3 }
        end,
    },
}
