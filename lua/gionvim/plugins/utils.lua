return {
    -- Terminal
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
    -- Pop-up key bindings and command window
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>a", group = "action/text" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    { "<leader>c", group = "command" },
                    { "<leader>e", group = "generate/editor" },
                    { "<leader>ep", group = "compiler" },
                    { "<leader>f", group = "find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gl", group = "lazygit" },
                    { "<leader>h", group = "highlight" },
                    { "<leader>j", group = "langextra" },
                    { "<leader>l", group = "lsp" },
                    { "<leader>lg", group = "lspsaga" },
                    { "<leader>m", group = "+manager/mark" },
                    { "<leader>n", group = "filetree" },
                    { "<leader>o", group = "option" },
                    { "<leader>r", group = "replace/rename" },
                    { "<leader>rr", group = "muren" },
                    { "<leader>s", group = "show/search" },
                    { "<leader>t", group = "terminal/todo" },
                    { "<leader>td", group = "todo" },
                    { "<leader>tt", group = "toggleterm" },
                    { "<leader>u", group = "ui/message" },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    { "<leader>y", group = "operate/yank" },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "z", group = "fold" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            if not vim.tbl_isempty(opts.defaults) then
                GionVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
                wk.register(opts.defaults)
            end
        end,
    },
    -- Inactive code dimmed
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
    -- Zen mode
    {
        "folke/zen-mode.nvim",
        lazy = true,
        keys = {
            { "<leader>az", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
        },
        opts = {},
    },
}
