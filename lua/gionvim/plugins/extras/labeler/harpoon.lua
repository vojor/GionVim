return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        },
        keys = function()
            local keys = {
                {
                    "<leader>mf",
                    function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Harpoon File",
                },
                {
                    "<leader>mh",
                    function()
                        local harpoon = require("harpoon")
                        harpoon.ui:toggle_quick_menu(harpoon:list())
                    end,
                    desc = "Harpoon Quick Menu",
                },
                {
                    "<leader>mp",
                    function()
                        require("harpoon"):list():prev()
                    end,
                    desc = "Harpoon Prev File",
                },
                {
                    "<leader>mn",
                    function()
                        require("harpoon"):list():next()
                    end,
                    desc = "Harpoon Next File",
                },
            }

            for i = 1, 5 do
                table.insert(keys, {
                    "<leader>m" .. i,
                    function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Harpoon to File " .. i,
                })
            end
            return keys
        end,
    },
}
