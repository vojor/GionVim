return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>k", "", desc = "fuzzy" },
            { "<c-j>", "<Down>", ft = "fzf", mode = "t", nowait = true },
            { "<c-k>", "<Up>", ft = "fzf", mode = "t", nowait = true },
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
            fzf_colors = {
                ["fg"] = { "fg", "CursorLine" },
                ["bg"] = { "bg", "Normal" },
                ["hl"] = { "fg", "Comment" },
                ["fg+"] = { "fg", "Normal" },
                ["bg+"] = { "bg", "CursorLine" },
                ["hl+"] = { "fg", "Statement" },
                ["info"] = { "fg", "PreProc" },
                ["prompt"] = { "fg", "Conditional" },
                ["pointer"] = { "fg", "Exception" },
                ["marker"] = { "fg", "Keyword" },
                ["spinner"] = { "fg", "Label" },
                ["header"] = { "fg", "Comment" },
                ["gutter"] = { "bg", "Normal" },
            },
            btags = {
                file_icons = true,
                git_icons = true,
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
