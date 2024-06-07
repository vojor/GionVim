return {
    {
        "folke/trouble.nvim",
        lazy = true,
        cmd = "Trouble",
        keys = {
            { "<leader>xg", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
            { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>xd", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            {
                "<leader>xn",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
            {
                "[Q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").prev({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous Trouble/Quickfix Item",
            },
        },
        opts = {
            auto_preview = false,
            preview = { type = "float" },
            keys = {
                j = "next",
                k = "prev",
            },
        },
    },
}
