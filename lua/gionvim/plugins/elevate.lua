return {
    -- Perfect old quickfix window
    {
        "stevearc/quicker.nvim",
        lazy = true,
        event = "FileType qf",
        keys = {
            {
                "<leader>cC",
                function()
                    require("quicker").toggle()
                end,
                desc = "Toggle quickfix",
            },
            {
                "<leader>cL",
                function()
                    require("quicker").toggle({ loclist = true })
                end,
                desc = "Toggle loclist",
            },
        },
        config = function()
            require("quicker").setup({
                keys = {
                    {
                        ">",
                        function()
                            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                        end,
                        desc = "Expand quickfix context",
                    },
                    {
                        "<",
                        function()
                            require("quicker").collapse()
                        end,
                        desc = "Collapse quickfix context",
                    },
                },
            })
        end,
    },
    -- Strengthen w,e,b function
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
            { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
            { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
        },
    },
    -- Convenient file operate
    {
        "chrisgrieser/nvim-genghis",
        lazy = true,
        cmd = "Genghis",
        keys = {
            {
                "<leader>yu",
                function()
                    require("genghis").duplicateFile()
                end,
                desc = "Duplicate File",
            },
            {
                "<leader>yp",
                function()
                    require("genghis").copyFilepath()
                end,
                desc = "Copy File Path",
            },
            {
                "<leader>ym",
                function()
                    require("genghis").copyFilename()
                end,
                desc = "Copy File Name",
            },
            {
                "<leader>yx",
                function()
                    require("genghis").chmodx()
                end,
                desc = "Make File Chmod +X",
            },
            {
                "<leader>yn",
                function()
                    require("genghis").createNewFile()
                end,
                desc = "Create New File",
            },
            {
                "<leader>yf",
                function()
                    require("genghis").renameFile()
                end,
                desc = "Rename File",
            },
            {
                "<leader>yo",
                function()
                    require("genghis").moveAndRenameFile()
                end,
                desc = "Move And Rename File",
            },
            {
                "<leader>yR",
                function()
                    require("genghis").trashFile()
                end,
                desc = "File Trash",
            },
            {
                "<leader>ys",
                function()
                    require("genghis").moveSelectionToNewFile()
                end,
                mode = "x",
                desc = "Move Selection To New File",
            },
            {
                "<leader>yT",
                function()
                    require("genghis").moveToFolderInCwd()
                end,
                desc = "Move File To Current CWD",
            },
        },
        opts = {},
    },
    -- Enhance Yank and Put function
    {
        "gbprod/yanky.nvim",
        lazy = true,
        keys = {
            { "<leader>yr", "<cmd>YankyRingHistory<CR>", desc = "Show Yanky History" },
            { "<leader>yc", "<cmd>YankyClearHistory<CR>", desc = "clear Yanky History" },
            { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
            { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
            { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
            { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put text after selection" },
            { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put text before selection" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
            { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
            { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
            { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
            { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
        },
        dependencies = { "sqlite.lua" },
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 200,
                    permanent_wrapper = require("yanky.wrappers").remove_carriage_return,
                    storage = "sqlite",
                },
                highlight = { timer = 150 },
            })
        end,
    },
}
