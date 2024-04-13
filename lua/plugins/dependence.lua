return {
    -- 减少 lua 函数的编写
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- neovim 的 UI 组件库
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
    -- 图标支持插件
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
    -- 提供对 sqlite 数据库的操作
    {
        "kkharji/sqlite.lua",
        lazy = true,
    },
    -- 提供对 json,yaml 文件的 schemascore 访问
    {

        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    -- 异步IO库
    {
        "nvim-neotest/nvim-nio",
        lazy = true,
    },
    -- 简化luarocks包安装
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    -- 管理lsp,dap,diagnostics,formatting服务的安装
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
