return {
    -- Enhance default vim.ui interface
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
        opts = {},
    },
    -- Prefect old quickfix window
    {
        "kevinhwang91/nvim-bqf",
        lazy = true,
        ft = "qf",
        init = function()
            function _G.qftf(info)
                local items
                local ret = {}
                if info.quickfix == 1 then
                    items = vim.fn.getqflist({ id = info.id, items = 0 }).items
                else
                    items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
                end
                local limit = 31
                local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
                local validFmt = "%s │%5d:%-3d│%s %s"
                for i = info.start_idx, info.end_idx do
                    local e = items[i]
                    local fname = ""
                    local str
                    if e.valid == 1 then
                        if e.bufnr > 0 then
                            fname = vim.fn.bufname(e.bufnr)
                            if fname == "" then
                                fname = "[No Name]"
                            else
                                fname = fname:gsub("^" .. vim.env.HOME, "~")
                            end
                            if #fname <= limit then
                                fname = fnameFmt1:format(fname)
                            else
                                fname = fnameFmt2:format(fname:sub(1 - limit))
                            end
                        end
                        local lnum = e.lnum > 99999 and -1 or e.lnum
                        local col = e.col > 999 and -1 or e.col
                        local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
                        str = validFmt:format(fname, lnum, col, qtype, e.text)
                    else
                        str = e.text
                    end
                    table.insert(ret, str)
                end
                return ret
            end

            vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
        end,
        opts = {
            auto_enable = true,
            auto_resize_height = true,
            preview = {
                win_height = 12,
                win_vheight = 12,
                delay_syntax = 80,
                border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
                show_title = true,
            },
            func_map = {
                drop = "o",
                openc = "O",
                split = "<C-s>",
                tabdrop = "<C-t>",
                vsplit = "",
                ptogglemode = "z,",
                stoggleup = "",
            },
            filter = {
                fzf = {
                    action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                    extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
                },
            },
        },
        config = function(_, opts)
            vim.cmd([[
                hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
                hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
                hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
                hi BqfPreviewSbar guifg=#ae4d55 ctermfg=172
                hi BqfPreviewCursor guifg=#d75f00 ctermfg=166
                hi link BqfPreviewRange Search
            ]])

            require("bqf").setup(opts)
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
    -- Improeve buffer close
    {
        "ojroques/nvim-bufdel",
        lazy = true,
        keys = {
            { "<leader>bd", "<cmd>BufDel<CR>", desc = "Close Current Buffer" },
            { "<leader>bi", "<cmd>BufDel!<CR>", desc = "Close Current Buffer And Ignore Modify" },
            { "<leader>ba", "<cmd>BufDelAll<CR>", desc = "Close All Buffers" },
            { "<leader>bo", "<cmd>BufDelOthers<CR>", desc = "Close Others Buffer" },
            { "<leader>bs", ":BufDel ", desc = "Close Specify Buffer(Name Number Use '')" },
        },
        opts = {
            quit = false,
        },
    },
    -- Convenient file operate
    {
        "chrisgrieser/nvim-genghis",
        lazy = true,
        keys = function()
            local genghis = require("genghis")
            local keys = {
                { "<leader>yp", genghis.copyFilepath, desc = "Copy File Path" },
                { "<leader>ym", genghis.copyFilename, desc = "Copy File Name" },
                { "<leader>yx", genghis.chmodx, desc = "Make File Chmod +X" },
                { "<leader>yf", genghis.renameFile, desc = "Rename File" },
                { "<leader>yo", genghis.moveAndRenameFile, desc = "Move And Rename File" },
                { "<leader>yn", genghis.createNewFile, desc = "Create New File" },
                { "<leader>yu", genghis.duplicateFile, desc = "Duplicate File" },
                { "<leader>yR", genghis.trashFile, desc = "File Trash" },
                { "<leader>ys", genghis.moveSelectionToNewFile, mode = "x", desc = "Move Selection To New File" },
            }
            return keys
        end,
        init = function()
            vim.g.genghis_use_systemclipboard = true
            vim.g.genghis_disable_commands = true
        end,
        dependencies = { "dressing.nvim" },
    },
    -- Enhance Yank and Put function
    {
        "gbprod/yanky.nvim",
        lazy = true,
        keys = {
            { "<leader>yr", "<cmd>YankyRingHistory<CR>", desc = "Show Yanky History" },
            { "<leader>yc", "<cmd>YankyClearHistory<CR>", desc = "clear Yanky History" },
            -- stylua: ignore
            { "<leader>yt", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History" },
            { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
            { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
            { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor" },
            { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
            { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
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
        opts = {
            ring = {
                history_length = 200,
                storage = "sqlite",
            },
            highlight = { timer = 150 },
        },
    },
    -- Enhance terminal
    {
        "2KAbhishek/termim.nvim",
        cmd = { "Fterm", "FTerm", "Sterm", "STerm", "Vterm", "VTerm" },
        keys = {
            { "<leader>tf", ":Fterm", desc = "Open Terminal In New Tab" },
            { "<leader>ts", ":Sterm", desc = "Open Terminal In New Horizontal Split" },
            { "<leader>tv", ":Vterm", desc = "Open Terminal In New Vertical Split" },
        },
    },
}
