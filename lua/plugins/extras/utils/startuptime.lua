return {
    -- 测量启动时间
    {
        "dstein64/vim-startuptime",
        lazy = true,
        keys = {
            { "<leader>st", "<cmd>StartupTime<CR>", desc = "Show Neovim Start Time" },
        },
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
}
