return {
    -- In function, method, etc show context virtual text
    {
        "andersevenrud/nvim_context_vt",
        lazy = true,
        ft = { "c", "cpp", "java", "lua", "python", "typescript", "javascript", "typescriptreact", "javascriptreact" },
        opts = {
            prefix = "",
            disable_virtual_lines_ft = { "yaml", "toml" },
        },
        config = function(opts)
            require("nvim_context_vt").setup(opts)
            vim.keymap.set("n", "<leader>ov", "<cmd>NvimContextVtToggle<CR>", { desc = "Toggle Context Virtual Text" })
        end,
    },
    -- Exhibit function head
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = function()
            local tsc = require("treesitter-context")

            local key = {
                {
                    "[x",
                    function()
                        tsc.go_to_context()
                    end,
                    desc = "Goto Code Start",
                },
            }

            return key
        end,
        opts = function()
            local tsc = require("treesitter-context")

            GionVim.toggle.map("<leader>oT", {
                name = "Treesitter Context",
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            })

            return { mode = "cursor", max_lines = 3 }
        end,
    },
}
