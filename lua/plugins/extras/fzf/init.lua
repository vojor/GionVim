return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>kl", "<cmd>FzfLua<CR>", desc = "Fzf Args Select List" },
            { "<leader>kf", "<cmd>FzfLua files<CR>", desc = "Fzf Find Files" },
            { "<leader>kg", "<cmd>FzfLua live_grep<CR>", desc = "Fzf Find Text" },
            { "<leader>kj", "<cmd>FzfLua jumps<CR>", desc = "Fzf Jump" },
        },
        dependencies = { "nvim-web-devicons" },
        opts = {
            winopts = {
                title = "Fzf Search",
                title_pos = "center",
                preview = {
                    winopts = {
                        relativenumber = true,
                    },
                },
            },
            lsp = {
                git_icons = true,
                finder = {
                    git_icons = true,
                },
            },
            diagnostics = {
                git_icons = true,
            },
            complete_file = {
                git_icons = true,
            },
        },
    },
}
