return {
    {
        "linux-cultist/venv-selector.nvim",
        lazy = true,
        ft = "python",
        cmd = "VenvSelect",
        keys = {
            { "<leader>sv", "<cmd>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" },
        },
        opts = {
            options = {
                notify_user_on_venv_activation = true,
            },
        },
    },
}
