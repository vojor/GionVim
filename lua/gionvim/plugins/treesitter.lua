return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local ensure_installed = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "diff",
                "git_config",
                "gitcommit",
                "gitignore",
                "html",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "norg",
                "python",
                "query",
                "regex",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            }
            require("nvim-treesitter").install(ensure_installed):wait(300000)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = ensure_installed,
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
