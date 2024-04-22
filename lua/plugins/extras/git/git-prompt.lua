return {
    {
        "mikesmithgh/git-prompt-string-lualine.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts, {
                sections = {
                    lualine_b = { "git_prompt_string" },
                },
            })
        end,
    },
}
