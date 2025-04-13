return {
    {
        "kevinhwang91/nvim-hlslens",
        lazy = true,
        keys = {
            {
                "n",
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                mode = "n",
            },
            {
                "N",
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                mode = "n",
            },
            {
                "*",
                [[:let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=1<CR>:lua require('hlslens').start()<CR>nzv]],
                mode = "n",
            },
            {
                "#",
                [[:let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=0<CR>:lua require('hlslens').start()<CR>nzv]],
                mode = "n",
            },
            {
                "g*",
                [[:let @/='\v'.expand('<cword>')<CR>:let v:searchforward=1<CR>:lua require('hlslens').start()<CR>nzv]],
                mode = "n",
            },
            {
                "g#",
                [[:let @/='\v'.expand('<cword>')<CR>:let v:searchforward=0<CR>:lua require('hlslens').start()<CR>nzv]],
                mode = "n",
            },
        },
        config = function()
            require("scrollbar.handlers.search").setup({
                calm_down = true,
                nearest_only = true,
                nearest_float_when = "always",
            })
            vim.keymap.set("n", "<leader>hg", "<cmd>HlSearchLensToggle<CR>", { desc = "Toggle hlslens" })
            vim.keymap.set({ "n", "x" }, "<leader>hl", function()
                vim.schedule(function()
                    if require("hlslens").exportLastSearchToQuickfix() then
                        vim.cmd("cw")
                    end
                end)
                return "<cmd>noh<CR>"
            end, { expr = true, desc = "Export Last Search To QuickFix" })
        end,
    },
}
