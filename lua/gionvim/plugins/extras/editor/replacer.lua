return {
    {
        "AckslD/muren.nvim",
        lazy = true,
        keys = {
            { "<leader>rrg", "<cmd>MurenToggle<CR>", desc = "Toggle Muren Interface" },
            { "<leader>rrf", "<cmd>MurenFresh<CR>", desc = "Open The Muren UI Fresh" },
            { "<leader>rru", "<cmd>MurenUnique<CR>", desc = "Unique Muren" },
        },
        opts = {},
    },
    {
        "nvim-pack/nvim-spectre",
        build = false,
        lazy = true,
        cmd = "Spectre",
        keys = {
            {
                "<leader>rg",
                function()
                    require("spectre").toggle()
                end,
                desc = "Toggle Spectre",
            },
            {
                "<leader>rw",
                function()
                    require("spectre").open_visual({ select_word = true })
                end,
                desc = "Search Current Word",
            },
            {
                "<leader>rw",
                function()
                    require("spectre").open_visual()
                end,
                mode = "v",
                desc = "Search Current Word",
            },
            {
                "<leader>rt",
                function()
                    require("spectre").open_file_search({ select_word = true })
                end,
                desc = "Search On Current File",
            },
        },
        opts = {
            open_cmd = "noswapfile vnew",
            live_update = true,
            is_block_ui_break = true,
            mapping = {
                ["toggle_line"] = {
                    map = "<leader>ra",
                },
                ["enter_file"] = {
                    map = "<CR>",
                },
                ["send_to_qf"] = {
                    map = "<leader>rq",
                },
                ["replace_cmd"] = {
                    map = "<leader>rd",
                },
                ["show_option_menu"] = {
                    map = "<leader>re",
                },
                ["run_current_replace"] = {
                    map = "<leader>rr",
                },
                ["run_replace"] = {
                    map = "<leader>rp",
                },
                ["change_view_mode"] = {
                    map = "<leader>ri",
                },
                ["change_replace_sed"] = {
                    map = "<leader>ru",
                },
                ["change_replace_oxi"] = {
                    map = "<leader>rx",
                },
                ["toggle_live_update"] = {
                    map = "<leader>rj",
                },
                ["toggle_ignore_case"] = {
                    map = "<leader>rk",
                },
                ["toggle_ignore_hidden"] = {
                    map = "<leader>rs",
                },
                ["resume_last_search"] = {
                    map = "<leader>rl",
                },
            },
        },
    },
}
