return {
    {
        "sachinsenal0x64/hot.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            vim.opt.autochdir = true
        end,
        config = function()
            local opts = require("hot.params").opts

            Reloader = opts.tweaks.default
            Reloader = "💤"

            Pattern = opts.tweaks.patterns
            Pattern = { "main.py", "main.go" }

            opts.tweaks.start = "🚀"
            opts.tweaks.stop = "💤"
            opts.tweaks.test = "🧪"
            opts.tweaks.test_done = "🧪.✅"
            opts.tweaks.test_fail = "🧪.❌"

            opts.tweaks.custom_file = "index"

            opts.set.languages.python = {
                cmd = "python3",
                desc = "Run Python file asynchronously",
                kill_desc = "Kill the running Python file",
                emoji = "🐍",
                test = "python -m unittest -v",
                ext = { ".py" },
            }

            opts.set.languages.go = {
                cmd = "go run",
                desc = "Run Go file asynchronously",
                kill_desc = "Kill the running Go file",
                emoji = "🐹",
                test = "go test",
                ext = { ".go" },
            }

            vim.keymap.set("n", "<leader>co", '<cmd>lua require("thot").check()<CR>', { noremap = true, silent = true })

            vim.keymap.set("n", "<F3>", '<cmd>lua require("hot").restart()<CR>', { noremap = true, silent = true })
            vim.keymap.set("n", "<F4>", '<cmd>lua require("hot").silent()<CR>', { noremap = true, silent = true })
            -- Stop
            vim.keymap.set("n", "<F5>", '<cmd>lua require("hot").stop()<CR>', { noremap = true, silent = true })
            -- Test
            vim.keymap.set("n", "<F6>", '<cmd>lua require("hot").test_restart()<CR>', { noremap = true, silent = true })
            -- Close Buffer
            vim.keymap.set(
                "n",
                "<F8>",
                '<cmd>lua require("hot").close_output_buffer()<CR>',
                { noremap = true, silent = true }
            )
            -- Open Buffer
            vim.keymap.set(
                "n",
                "<F7>",
                '<cmd>lua require("hot").open_output_buffer()<CR>',
                { noremap = true, silent = true }
            )

            local save_group = vim.api.nvim_create_augroup("save_mapping", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePost", {
                desc = "Reloader",
                group = save_group,
                pattern = Pattern,
                callback = function()
                    require("hot").silent()
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts, {
                sections = {
                    lualine_b = { { "Reloader" } },
                },
            })
        end,
    },
}
