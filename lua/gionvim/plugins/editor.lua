return {
    -- Jump
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
            {
                "<c-space>",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter({
                        actions = {
                            ["<c-space>"] = "next",
                            ["<BS>"] = "prev",
                        },
                    })
                end,
                desc = "Treesitter Incremental Selection",
            },
        },
        opts = {
            jump = {
                pos = "ranger",
                register = true,
            },
            label = {
                rainbow = {
                    enabled = true,
                },
            },
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        },
    },
    -- Text Move
    {
        "nvim-mini/mini.move",
        lazy = true,
        keys = {
            { "<M-j>", mode = { "n", "x" } },
            { "<M-k>", mode = { "n", "x" } },
            { "<M-l>", mode = { "n", "v" } },
            { "<M-h>", mode = { "n", "v" } },
        },
        opts = {},
    },
    -- Text objects
    {
        "nvim-mini/mini.ai",
        lazy = true,
        event = "LazyFile",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                    d = { "%f[%d]%d+" },
                    e = {
                        {
                            "%u[%l%d]+%f[^%l%d]",
                            "%f[%S][%l%d]+%f[^%l%d]",
                            "%f[%P][%l%d]+%f[^%l%d]",
                            "^[%l%d]+%f[^%l%d]",
                        },
                        "^().*()$",
                    },
                    g = GionVim.mini.ai_buffer,
                    u = ai.gen_spec.function_call(),
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
            GionVim.on_load("which-key.nvim", function()
                vim.schedule(function()
                    GionVim.mini.ai_whichkey(opts)
                end)
            end)
        end,
    },
    -- Text replace
    {
        "MagicDuck/grug-far.nvim",
        lazy = true,
        cmd = "GrugFar",
        opts = {
            headerMaxWidth = 80,
            engines = {
                ripgrep = {
                    extraArgs = "--pcre2",
                },
            },
        },
        keys = {
            {
                "<leader>rg",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Grug Search and Replace",
            },
            {
                "<leader>rG",
                function()
                    require("grug-far").open({ engine = "astgrep", transient = true })
                end,
                desc = "Grug Use Ast-Grep",
            },
        },
    },
    -- character、color、number increment or decrement
    {
        "monaqa/dial.nvim",
        lazy = true,
        keys = {
            { "<M-c>", desc = "Word Increment" },
            { "<M-d>", desc = "Word Decrement" },
            { "<M-f>", desc = "Color Increment" },
            { "<M-g>", desc = "Color Decrement" },
            { "<M-x>", desc = "Date Increment" },
            { "<M-y>", desc = "Date Decrement" },
        },
        config = function()
            local augend = require("dial.augend")

            require("dial.config").augends:register_group({
                -- Character
                chars_dial = {
                    augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "and", "or", "not" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "if", "else" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "left", "right" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "out", "in" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "up", "down" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "disable", "enable" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "disabled", "enabled" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "output", "input" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "front", "rear" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "start", "end" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "top", "bottom" }, word = true, cyclic = true }),
                    augend.constant.new({
                        elements = {
                            "January",
                            "February",
                            "March",
                            "April",
                            "May",
                            "June",
                            "July",
                            "August",
                            "September",
                            "October",
                            "November",
                            "December",
                        },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({ elements = { "+", "-" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "*", "/" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { ">", "<" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "=", "!=" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "|", "&" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "||", "&&" }, word = false, cyclic = true }),
                    augend.constant.new({
                        elements = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" },
                        word = false,
                        cyclic = true,
                    }),
                },

                -- Color
                color_dial = {
                    augend.hexcolor.new({
                        case = "lower",
                    }),
                },

                -- Date
                date_dial = {
                    augend.date.new({
                        pattern = "%Y/%m/%d",
                        default_kind = "day",
                        only_valid = true,
                        word = false,
                    }),
                    augend.date.new({
                        pattern = "%Y-%m-%d",
                        default_kind = "day",
                        only_valid = true,
                        word = false,
                    }),
                },
            })
            vim.keymap.set("n", "<M-c>", function()
                require("dial.map").manipulate("increment", "normal", "chars_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-d>", function()
                require("dial.map").manipulate("decrement", "normal", "chars_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-f>", function()
                require("dial.map").manipulate("increment", "normal", "color_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-g>", function()
                require("dial.map").manipulate("decrement", "normal", "color_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-x>", function()
                require("dial.map").manipulate("increment", "normal", "date_dial")
            end, { noremap = true })
            vim.keymap.set("n", "<M-y>", function()
                require("dial.map").manipulate("decrement", "normal", "date_dial")
            end, { noremap = true })
        end,
    },
    -- Trim space and blank
    {
        "nvim-mini/mini.trailspace",
        version = false,
        lazy = true,
        keys = {
            {
                "<leader>cb",
                function()
                    require("mini.trailspace").trim()
                end,
                desc = "Trim All Trailing Spaces",
            },
            {
                "<leader>cB",
                function()
                    require("mini.trailspace").trim_last_lines()
                end,
                desc = "Trim All Blank Line",
            },
        },

        config = function()
            require("mini.trailspace").setup()
        end,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "checkhealth",
                    "help",
                    "lazy",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "grug-far",
                    "qf",
                    "Trouble",
                    "trouble",
                },
                callback = function()
                    vim.b.minitrailspace_disable = true
                end,
            })
        end,
    },
}
