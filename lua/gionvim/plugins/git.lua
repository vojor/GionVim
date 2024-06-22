return {
    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "plenary.nvim" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "▎" },
                    untracked = { text = "★" },
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
                    map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Undo Stage Hunk")
                    map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Buffer")
                    map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Hunk")
                    map("n", "<leader>gP", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
                    map("n", "<leader>gb", function()
                        gitsigns.blame_line({ full = true })
                    end, "Blame Line")
                    map("n", "<leader>gf", function()
                        gitsigns.blame()
                    end, "Blame buffer")
                    map("n", "<leader>gB", gitsigns.toggle_current_line_blame, "Current Blame Line")
                    map("n", "<leader>gd", gitsigns.diffthis, "Diff This")
                    map("n", "<leader>gD", function()
                        gitsigns.diffthis("~")
                    end, "Diff This ~")
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
                end,
            })
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}
