return {
    {
        "romgrk/barbar.nvim",
        enabled = false,
        event = "VeryLazy",
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        keys = {
            { "<M-p>", "<cmd>BufferPrevious<CR>", desc = "Goto Previous Buffer" },
            { "<M-n>", "<cmd>BufferNext<CR>", desc = "Goto Next Buffer" },
            { "<leader>bl", "<cmd>BufferClose<CR>", desc = "Close Buffer" },
            { "<leader>bn", "<cmd>BufferPin<CR>", desc = "Pin Buffer" },
            { "<leader>bt", "<cmd>BufferOrderByBufferNumber<CR>", desc = "Buffer Sort By Number" },
            { "<leader>br", "<cmd>BufferOrderByDirectory<CR>", desc = "Buffer Sort By Directory" },
            { "<leader>be", "<cmd>BufferOrderByLanguage<CR>", desc = "Buffer Sort By Language" },
            { "<leader>bw", "<cmd>BufferOrderByWindowNumber<CR>", desc = "Buffer Sort By Window Number" },
        },
        dependencies = {
            { "nvim-web-devicons" },
        },
        opts = {
            highlight_inactive_file_icons = true,
            highlight_visible = false,
            icons = {
                buffer_index = true,
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
                    [vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
                visible = { modified = { buffer_number = true } },
            },
            insert_at_end = true,
            sidebar_filetypes = {
                aerial = { event = "BufWinLeave", text = "outline" },
            },
        },
    },
}
