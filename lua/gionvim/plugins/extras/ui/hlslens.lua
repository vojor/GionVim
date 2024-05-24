return {
    {
        "kevinhwang91/nvim-hlslens",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>hg", "<cmd>HlSearchLensToggle<CR>", desc = "Toggle Highlight Search Lens" },
        },
        config = function()
            require("scrollbar.handlers.search").setup({
                calm_down = true,
                nearest_only = true,
                nearest_float_when = "always",
            })
            local kopts = { noremap = true, silent = true }
            vim.keymap.set(
                "n",
                "n",
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts
            )
            vim.keymap.set(
                "n",
                "N",
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts
            )
            vim.keymap.set(
                "n",
                "*",
                [[:let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=1<CR>:lua require('hlslens').start()<CR>nzv]],
                kopts
            )
            vim.keymap.set(
                "n",
                "#",
                [[:let @/='\v<'.expand('<cword>').'>'<CR>:let v:searchforward=0<CR>:lua require('hlslens').start()<CR>nzv]],
                kopts
            )
            vim.keymap.set(
                "n",
                "g*",
                [[:let @/='\v'.expand('<cword>')<CR>:let v:searchforward=1<CR>:lua require('hlslens').start()<CR>nzv]],
                kopts
            )
            vim.keymap.set(
                "n",
                "g#",
                [[:let @/='\v'.expand('<cword>')<CR>:let v:searchforward=0<CR>:lua require('hlslens').start()<CR>nzv]],
                kopts
            )
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
