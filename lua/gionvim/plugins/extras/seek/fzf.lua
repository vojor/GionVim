local function symbols_filter(entry, ctx)
    if ctx.symbols_filter == nil then
        ctx.symbols_filter = GionVim.config.get_kind_filter(ctx.bufnr) or false
    end
    if ctx.symbols_filter == false then
        return true
    end
    return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>k", "", desc = "fuzzy" },
            { "<c-j>", "<Down>", ft = "fzf", mode = "t", nowait = true },
            { "<c-k>", "<Up>", ft = "fzf", mode = "t", nowait = true },
            { "<leader>kl", "<cmd>FzfLua<CR>", desc = "Fzf Args Select List" },
            { "<leader>kb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
            { "<leader>kf", "<cmd>FzfLua files<CR>", desc = "Find Files" },
            { "<leader>kg", "<cmd>FzfLua live_grep<CR>", desc = "Find Text" },
            { "<leader>kc", "<cmd>FzfLua grep_curbuf<CR>", desc = "Find Text (current buffer)" },
            { "<leader>ki", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
            { "<leader>ku", "<cmd>FzfLua git_status<CR>", desc = "Status" },
            { "<leader>kj", "<cmd>FzfLua jumps<CR>", desc = "Fzf Jump" },
            {
                "<leader>ks",
                function()
                    require("fzf-lua").lsp_document_symbols({
                        regex_filter = symbols_filter,
                    })
                end,
                desc = "Goto Symbol",
            },
            {
                "<leader>kS",
                function()
                    require("fzf-lua").lsp_live_workspace_symbols({
                        regex_filter = symbols_filter,
                    })
                end,
                desc = "Goto Symbol (Workspace)",
            },
        },
        opts = {
            fzf_bin = "sk",
            winopts = {
                title = "Fzf Search",
                title_pos = "center",
                preview = {
                    winopts = {
                        relativenumber = true,
                    },
                },
            },
            defaults = {
                formatter = "path.dirname_first",
            },
            fzf_colors = {
                ["fg"] = { "fg", "CursorLine" },
                ["bg"] = { "bg", "Normal" },
                ["hl"] = { "fg", "Comment" },
                ["fg+"] = { "fg", "Normal" },
                ["bg+"] = { "bg", "CursorLine" },
                ["hl+"] = { "fg", "Statement" },
                ["info"] = { "fg", "PreProc" },
                ["prompt"] = { "fg", "Conditional" },
                ["pointer"] = { "fg", "Exception" },
                ["marker"] = { "fg", "Keyword" },
                ["spinner"] = { "fg", "Label" },
                ["header"] = { "fg", "Comment" },
                ["gutter"] = { "bg", "Normal" },
            },
            btags = {
                file_icons = true,
                git_icons = true,
            },
            lsp = {
                git_icons = true,
                finder = {
                    git_icons = true,
                },
                symbols = {
                    symbol_hl = function(s)
                        return "TroubleIcon" .. s
                    end,
                    symbol_fmt = function(s)
                        return s:lower() .. "\t"
                    end,
                    child_prefix = false,
                },
                code_actions = {
                    previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
                },
            },
            diagnostics = {
                git_icons = true,
            },
            complete_file = {
                git_icons = true,
            },
        },
    },
}
