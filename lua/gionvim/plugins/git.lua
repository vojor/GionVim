return {
    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "LazyFile",
        dependencies = { "plenary.nvim" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "★" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            numhl = true,
            attach_to_untracked = true,
            on_attach = function(buffer)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, "Prev Hunk")
                map("n", "]H", function()
                    gitsigns.nav_hunk("last")
                end, "Last Hunk")
                map("n", "[H", function()
                    gitsigns.nav_hunk("first")
                end, "First Hunk")

                map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Hunk")
                map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Hunk")

                map("v", "<leader>gs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage Hunk")
                map("v", "<leader>gr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset Hunk")

                map("n", "<leader>gS", gitsigns.stage_buffer, "Stage Buffer")
                map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Buffer")
                map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk")
                map("n", "<leader>gP", gitsigns.preview_hunk_inline, "Preview Hunk Inline")

                map("n", "<leader>gb", function()
                    gitsigns.blame_line({ full = true })
                end, "Blame Line")
                map("n", "<leader>gB", function()
                    gitsigns.blame()
                end, "Blame buffer")

                map("n", "<leader>gd", gitsigns.diffthis, "Diff This")
                map("n", "<leader>gD", function()
                    gitsigns.diffthis("~")
                end, "Diff This ~")

                map("n", "<leader>gQ", function()
                    gitsigns.setqflist("all")
                end, "Set Qf List(All)")
                map("n", "<leader>gq", gitsigns.setqflist, "Set Qf List")

                map("n", "<leader>ge", gitsigns.toggle_current_line_blame, "Current Blame Line")
                map("n", "<leader>gw", gitsigns.toggle_word_diff, "Word Diff")

                map({ "o", "x" }, "ih", gitsigns.select_hunk, "GitSigns Select Hunk")
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    {
        "gitsigns.nvim",
        opts = function()
            Snacks.toggle({
                name = "Git Signs",
                get = function()
                    return require("gitsigns.config").config.signcolumn
                end,
                set = function(state)
                    require("gitsigns").toggle_signs(state)
                end,
            }):map("<leader>gG")
        end,
    },
}
