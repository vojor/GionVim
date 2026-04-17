local function term_nav(dir)
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">"
            or vim.schedule(function()
                vim.cmd.wincmd(dir)
            end)
    end
end

return {
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
                    { "<leader>a", group = "swap" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    { "<leader>c", group = "order" },
                    { "<leader>e", group = "editor" },
                    { "<leader>f", group = "find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gl", group = "lazygit" },
                    { "<leader>h", group = "hl/color" },
                    { "<leader>j", group = "dynast" },
                    { "<leader>l", group = "lsp" },
                    { "<leader>lg", group = "lspsaga" },
                    { "<leader>n", group = "filetree" },
                    { "<leader>o", group = "switch" },
                    { "<leader>r", group = "replace/refactor" },
                    { "<leader>s", group = "gallery" },
                    { "<leader>t", group = "terminal/todo" },
                    { "<leader>td", group = "todo" },
                    { "<leader>u", group = "ui/message" },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    { "<leader>y", group = "operate/yanky" },
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
    -- snacks utils
    {
        "snacks.nvim",
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            dim = { animate = { enabled = false } },
            terminal = {
                win = {
                    keys = {
                        nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                        nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                        nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                        nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                        hide_slash = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
                        hide_underscore = { "<c-_>", "hide", desc = "which-key-ignore", mode = "t" },
                    },
                },
            },
        },
        keys = {
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
                "<leader>uP",
                function()
                    Snacks.profiler.scratch()
                end,
                desc = "Profiler Scratch Buffer",
            },
        },
    },
}
