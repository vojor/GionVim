return {
    -- 图标选择器
    {
        "ziontee113/icon-picker.nvim",
        lazy = true,
        keys = {
            { "<leader>ic", "<cmd>IconPickerNormal<CR>", desc = "Select Icon Insert Buffer" },
            { "<leader>iy", "<cmd>IconPickerYank<CR>", desc = "Select Icon Yank To Register" },
        },
        dependencies = { "telescope.nvim" },
        opts = {
            disable_legacy_commands = true,
        },
    },
}
