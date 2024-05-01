return {
    -- Reduce lua function writing
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- Neovim UI module
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
    -- Icons support
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
    -- Sqlite operate
    {
        "kkharji/sqlite.lua",
        lazy = true,
    },
    -- Uphold json and yaml files schemascore access
    {

        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    -- Async IO library
    {
        "nvim-neotest/nvim-nio",
        lazy = true,
    },
    -- Simply luarocks package installed
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    -- Manage lsp,dap,diagnostics,formatting serve install
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = true,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
        keys = {
            { "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason Manager Interface" },
        },
        opts = {
            log_level = vim.log.levels.ERROR,
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
}
