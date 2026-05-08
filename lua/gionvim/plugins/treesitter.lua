return {
    {
        "romus204/tree-sitter-manager.nvim",
        event = { "LazyFile", "VeryLazy" },
        keys = {
            { "<leader>jt", "<cmd>TSManager<CR>", desc = "Manager Tree Sitter " },
        },
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "cmake",
                    "diff",
                    "editorconfig",
                    "git_config",
                    "gitignore",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "json5",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                    "zsh",
                },
                border = "rounded",
            })
        end,
    },
}
