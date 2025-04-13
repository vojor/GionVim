return {
    -- Reduce lua function wrote
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- Neovim UI module
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
                [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
                [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
                [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
                [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
                ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
                ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
                ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
                ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
                ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    -- Operate SQLite
    {
        "kkharji/sqlite.lua",
        lazy = true,
    },
    -- Uphold json and yaml files schemastore access
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    -- Simply luarocks package mechanism
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    -- Manage code server mechanism
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = true,
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
        keys = {
            { "<leader>jm", "<cmd>Mason<CR>", desc = "Manage Server" },
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
