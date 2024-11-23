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
    -- Flash configure telescope
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function(_, opts)
            if not GionVim.has("flash.nvim") then
                return
            end
            local function flash(prompt_bufnr)
                require("flash").jump({
                    pattern = "^",
                    label = { after = { 0, 0 } },
                    search = {
                        mode = "search",
                        exclude = {
                            function(win)
                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                            end,
                        },
                    },
                    action = function(match)
                        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        picker:set_selection(match.pos[1] - 1)
                    end,
                })
            end
            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
            })
        end,
    },
    -- Text Move
    {
        "hinell/move.nvim",
        lazy = true,
        keys = {
            { "<M-j>", mode = { "n", "x" }, desc = "Down Move" },
            { "<M-k>", mode = { "n", "x" }, desc = "Up Move" },
            { "<M-l>", mode = { "n", "v" }, desc = "Right Move" },
            { "<M-h>", mode = { "n", "v" }, desc = "Left Move" },
            { "<leader>wl", desc = "Char Right Move" },
            { "<leader>wh", desc = "Char Left Move" },
        },
        config = function()
            local kopts = { noremap = true, silent = true }
            vim.keymap.set("n", "<M-j>", ":MoveLine 1<CR>", kopts)
            vim.keymap.set("n", "<M-k>", ":MoveLine -1<CR>", kopts)
            vim.keymap.set("n", "<M-l>", ":MoveHchar 1", kopts)
            vim.keymap.set("n", "<M-h>", ":MoveHchar -1<CR>", kopts)
            vim.keymap.set("n", "<leader>wl", ":MoveWord 1<CR>", kopts)
            vim.keymap.set("n", "<leader>wh", ":MoveWord -1<CR>", kopts)

            vim.keymap.set("x", "<M-j>", ":MoveBlock 1<CR>", kopts)
            vim.keymap.set("x", "<M-k>", ":MoveBlock -1<CR>", kopts)
            vim.keymap.set("v", "<M-l>", ":MoveHBlock 1<CR>", kopts)
            vim.keymap.set("v", "<M-h>", ":MoveHBlock -1<CR>", kopts)
        end,
    },
    -- Text replace
    {
        "MagicDuck/grug-far.nvim",
        lazy = true,
        cmd = "GrugFar",
        opts = {
            headerMaxWidth = 80,
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
                desc = "Search and Replace",
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
                    augend.constant.new({ elements = { "output", "input" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "front", "rear" }, word = true, cyclic = true }),
                    augend.constant.new({ elements = { "start", "end" }, word = true, cyclic = true }),
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
    -- Tickle space and blank
    {
        "echasnovski/mini.trailspace",
        version = false,
        lazy = true,
        keys = {
            {
                "<leader>cb",
                function()
                    require("mini.trailspace").trim()
                end,
                desc = "Trail All End of Line Space",
            },
            {
                "<leader>cB",
                function()
                    require("mini.trailspace").trim_last_lines()
                end,
                desc = "Trail All Blank Line",
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
                    "jqx",
                    "lazy",
                    "lspinfo",
                    "mason",
                    "neo-tree",
                    "notify",
                    "Outline",
                    "grug-far",
                    "qf",
                    "Trouble",
                    "trouble",
                    "toggleterm",
                },
                callback = function()
                    vim.b.minitrailspace_disable = true
                end,
            })
        end,
    },
}
