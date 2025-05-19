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
                    require("quicker").toggle({ open_cmd_mods = { split = "botright" } })
                end,
                desc = "Toggle [Q]uickfix",
            },
            {
                "<leader>cL",
                function()
                    require("quicker").toggle({ loclist = true })
                end,
                desc = "Toggle [L]oclist",
            },
            {
                "<leader>cA",
                function()
                    vim.fn.setqflist({}, "a", {
                        items = {
                            {
                                bufnr = vim.api.nvim_get_current_buf(),
                                lnum = vim.api.nvim_win_get_cursor(0)[1],
                                text = vim.api.nvim_get_current_line(),
                            },
                        },
                    })
                end,
                desc = "Add to [Q]uickfix",
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
            -- copy
            {
                "<leader>yp",
                function()
                    require("genghis").copyFilepathWithTilde()
                end,
                desc = "Copy File Absolute Path",
            },
            {
                "<leader>yP",
                function()
                    require("genghis").copyRelativePath()
                end,
                desc = "Copy File Relative Path",
            },
            {
                "<leader>yd",
                function()
                    require("genghis").copyDirectoryPath()
                end,
                desc = "Copy Directory Absolute path",
            },
            {
                "<leader>ym",
                function()
                    require("genghis").copyFilename()
                end,
                desc = "Copy File Name",
            },

            -- others
            {
                "<leader>yu",
                function()
                    require("genghis").duplicateFile()
                end,
                desc = "Duplicate File",
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
            {
                "<leader>ya",
                function()
                    require("genghis").navigateToFileInFolder("next")
                end,
                desc = "󰖽 Next file in folder",
            },
            {
                "<leader>yA",
                function()
                    require("genghis").navigateToFileInFolder("prev")
                end,
                desc = "󰖿 Prev file in folder",
            },
        },
        opts = {
            navigation = {
                onlySameExtAsCurrentFile = false,
                ignoreDotfiles = true,
            },
        },
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
