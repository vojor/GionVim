local function term_nav(dir)
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">"
            or vim.schedule(function()
                vim.cmd.wincmd(dir)
            end)
    end
end

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = function()
            return {
                notifier = { enabled = true },
                quickfile = { enabled = true },
                bigfile = { enabled = true },
                words = { enabled = true },
                toggle = { map = GionVim.safe_keymap_set },
                statuscolumn = { enabled = false },
                terminal = {
                    win = {
                        keys = {
                            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                        },
                    },
                },
            }
        end,
        keys = {
            {
                "<leader>uf",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Dismiss All Notifications",
            },
            {
                "<leader>ub",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>uS",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>uH",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Notification History",
            },
        },
        config = function(_, opts)
            local notify = vim.notify
            require("snacks").setup(opts)

            if GionVim.has("noice.nvim") then
                vim.notify = notify
            end
        end,
    },
}
