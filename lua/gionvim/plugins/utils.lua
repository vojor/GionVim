return {
    -- 终端
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = true,
        cmd = "ToggleTerm",
        keys = {
            { "<leader>ttg", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
            { "<leader>tta", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle All Terminal" },
            { "<leader>ttv", "<cmd>ToggleTerm direction=vertical size=45<CR>", desc = "Open Vertical Terminal" },
            { "<leader>tth", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Open Horizontal Terminal" },
            { "<leader>ttb", "<cmd>ToggleTerm direction=tab<CR>", desc = "Open Tab Terminal" },
            { "<leader>ttp", "<cmd>lua _htop_toggle()<CR>", desc = "Open Htop Terminal" },
            { "<leader>ttr", "<cmd>lua _procs_toggle()<CR>", desc = "Open Procs Terminal" },
            { "<leader>tte", ":TermExec ", desc = "Use Custom Operate Open Terminal" },
            { "<leader>ttc", ":ToggleTermSendCurrentLine ", desc = "Send Current Line To The Terminal" },
            { "<leader>tts", ":ToggleTermSendVisualLines ", desc = "Send Visual Line To The Terminal" },
            { "<leader>ttn", ":ToggleTermSendVisualSelection ", desc = "Send Visual Select Line To The Terminal" },
        },
        config = function()
            local Terminal = require("toggleterm.terminal").Terminal

            -- htop
            local htop = Terminal:new({
                cmd = "htop",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            function _htop_toggle()
                htop:toggle()
            end

            -- procs
            local procs = Terminal:new({
                cmd = "procs -t",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
            function _procs_toggle()
                procs:toggle()
            end

            require("toggleterm").setup({
                highlights = {
                    Normal = { link = "Normal" },
                    NormalNC = { link = "NormalNC" },
                    NormalFloat = { link = "NormalFloat" },
                    FloatBorder = { link = "FloatBorder" },
                    StatusLine = { link = "StatusLine" },
                    StatusLineNC = { link = "StatusLineNC" },
                    WinBar = { link = "WinBar" },
                    WinBarNC = { link = "WinBarNC" },
                },
                shading_factor = 2,
                persist_size = false,
                direction = "float",
                float_opts = {
                    border = "shadow",
                },
            })
        end,
    },
    -- 弹出按键绑定和输入命令窗口
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            window = {
                border = "shadow",
            },
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["z"] = { name = "+fold" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>a"] = { name = "+action/text" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+command" },
                ["<leader>d"] = { name = "+debug/diff" },
                ["<leader>dv"] = { name = "+diff" },
                ["<leader>dw"] = { name = "+widget debug" },
                ["<leader>e"] = { name = "+generate/editor" },
                ["<leader>ep"] = { name = "+compiler" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gl"] = { name = "+lazygit" },
                ["<leader>gn"] = { name = "+neogit" },
                ["<leader>h"] = { name = "+highlight" },
                ["<leader>i"] = { name = "+icon" },
                ["<leader>j"] = { name = "+langextra" },
                ["<leader>k"] = { name = "+fuzzy" },
                ["<leader>l"] = { name = "+lsp" },
                ["<leader>lg"] = { name = "+lspsaga" },
                ["<leader>m"] = { name = "+manager/mark" },
                ["<leader>n"] = { name = "+filetree" },
                ["<leader>o"] = { name = "+option" },
                ["<leader>p"] = { name = "+portal" },
                ["<leader>q"] = { name = "+session" },
                ["<leader>r"] = { name = "+replace/rename" },
                ["<leader>rr"] = { name = "+muren" },
                ["<leader>s"] = { name = "+show/search" },
                ["<leader>t"] = { name = "+terminal/todo" },
                ["<leader>td"] = { name = "+todo" },
                ["<leader>tt"] = { name = "+toggleterm" },
                ["<leader>u"] = { name = "+ui/message" },
                ["<leader>w"] = { name = "+window" },
                ["<leader>x"] = { name = "+diagnostics" },
                ["<leader>y"] = { name = "+operate/yank" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
    -- 非活动代码变暗
    {
        "folke/twilight.nvim",
        lazy = true,
        keys = {
            { "<leader>al", "<cmd>Twilight<CR>", desc = "Non active Code Shade" },
        },
        opts = {
            dimming = {
                inactive = true,
            },
            exclude = { "norg", "markdown", "tex", "text" },
        },
    },
    -- 禅模式
    {
        "folke/zen-mode.nvim",
        lazy = true,
        keys = {
            { "<leader>az", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
        },
        opts = {},
    },
}
