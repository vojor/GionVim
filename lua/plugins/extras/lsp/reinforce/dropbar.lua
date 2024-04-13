return {
    {
        -- Neovim Version 0.10 is necessity
        "Bekaboo/dropbar.nvim",
        enabled = false,
        init = function()
            vim.opt.mousemoveevent = true
        end,
        -- dependencies = { "telescope-fzf-native.nvim" },
        opts = {},
    },
}
