return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = true,
        event = "LazyFile",
        opts = {
            select = {
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<M-v>",
                },
            },
            move = {
                set_jumps = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)

            -- Select Mode keymaps
            vim.keymap.set({ "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ak", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ik", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "a?", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "i?", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "al", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "il", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "aa", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ia", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "as", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
            end)

            -- Swap Mode Keymaps
            vim.keymap.set("n", "<leader>ab", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@block.outer")
            end)
            vim.keymap.set("n", "<leader>af", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@function.outer")
            end)
            vim.keymap.set("n", "<leader>ap", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
            end)
            vim.keymap.set("n", "<leader>aB", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@block.outer")
            end)
            vim.keymap.set("n", "<leader>aF", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer")
            end)
            vim.keymap.set("n", "<leader>aP", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
            end)

            -- Move Mode Keymaps
            -- -- Move Goto Next Start
            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]c", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]k", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]a", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]o", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    { "@loop.inner", "@loop.outer" },
                    "textobjects"
                )
            end)
            vim.keymap.set({ "n", "x", "o" }, "]u", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]z", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
            end)

            -- -- Move Goto Next End
            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]C", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]K", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]A", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
            end)

            -- -- Nove Goto Previous Start
            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[c", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[k", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[a", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
            end)

            -- -- Move Goto Previous End
            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[C", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[K", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[A", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.outer", "textobjects")
            end)
        end,
    },
}
