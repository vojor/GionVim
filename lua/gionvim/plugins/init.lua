require("gionvim.config").init()

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {},
        config = function(_, opts)
            local notify = vim.notify
            require("snacks").setup(opts)

            if GionVim.has("noice.nvim") then
                vim.notify = notify
            end
        end,
    },
}
