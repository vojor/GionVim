local map = GionVim.safe_keymap_set

-- lazy
map("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Open Lazy Manager Interface" })

-- Lazy terminal
map("n", "<leader>tl", function()
    GionVim.terminal(nil, { cwd = GionVim.root() })
end, { desc = "Lazy Terminal (Root Dir)" })
map("n", "<leader>tL", function()
    GionVim.terminal()
end, { desc = "Lazy Terminal (CWD)" })

-- terminal mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<CR>", { desc = "Hide Terminal" })
map("t", "<C-_>", "<cmd>close<CR>", { desc = "which_key_ignore" })

-- lazygit
map("n", "<leader>glb", GionVim.lazygit.blame_line, { desc = "Git Blame Line" })
map("n", "<leader>glr", function()
    GionVim.lazygit({ cwd = GionVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>glR", function()
    GionVim.lazygit()
end, { desc = "Lazygit (CWD)" })
map("n", "<leader>glh", function()
    local git_path = vim.api.nvim_buf_get_name(0)
    GionVim.lazygit({ args = { "-f", vim.trim(git_path) } })
end, { desc = "Lazygit Current File History" })
map("n", "<leader>gll", function()
    GionVim.lazygit({ args = { "log" }, cwd = GionVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>glL", function()
    GionVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })
map("n", "<leader>glB", GionVim.lazygit.browse, { desc = "Git Browse" })

-- toggle options
map("n", "<leader>os", function()
    GionVim.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>ow", function()
    GionVim.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>oN", function()
    GionVim.toggle("relativenumber")
end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>on", function()
    GionVim.toggle.number()
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>od", function()
    GionVim.toggle.diagnostics()
end, { desc = "Toggle Diagnostics" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
    map("n", "<leader>oh", function()
        GionVim.toggle.inlay_hints()
    end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>ot", function()
    if vim.b.ts_highlight then
        vim.treesitter.stop()
    else
        vim.treesitter.start()
    end
end, { desc = "Toggle Treesitter Highlight" })

-- operate
map("n", "<leader>ce", "<cmd>enew<CR>", { desc = "New File" })
map("n", "<leader>cw", "<cmd>w<CR>", { desc = "Buffer Write File" })
map("n", "<leader>cW", "<cmd>wa<CR>", { desc = "Write All File" })
map("n", "<leader>cE", "<cmd>e!<CR>", { desc = "Revoke all file changes" })
map("n", "<leader>cq", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>cQ", "<cmd>q!<CR>", { desc = "Force Quit" })
map("n", "<leader>cx", "<cmd>x<CR>", { desc = "Save And Quit" })

-- quickfix/locallist
map("n", "<leader>cc", "<cmd>copen<CR>", { desc = "Open Quickfix" })
map("n", "<leader>cl", "<cmd>lopen<CR>", { desc = "Open Locationlist" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- checkhealth
map("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Neovim Health Check" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", GionVim.ui.bufremove, { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>:bd<CR>", { desc = "Delete Buffer and Window" })

-- window
map("n", "gh", "<c-w>h", { desc = "Goto left window" })
map("n", "gj", "<c-w>j", { desc = "Goto lower window" })
map("n", "gk", "<c-w>k", { desc = "Goto upper window" })
map("n", "gl", "<c-w>l", { desc = "Goto right window" })
map("n", "<leader>wv", "<C-W>v", { desc = "Horizontal addition window", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Vertical addition window", remap = true })
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>wm", function()
    GionVim.toggle.maximize()
end, { desc = "Maximize Toggle" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })

-- up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- keywordprg
map("n", "<leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg" })

-- search/highlight
map("n", "<leader>se", "/\\<lt>\\><left><left>")
map("n", "<leader>so", vim.show_pos, { desc = "Inspect Pos" })
map({ "i", "n" }, "<esc>", "<cmd>noh<CR><esc>", { desc = "Escape and clear hlsearch" })
map(
    "n",
    "<leader>hn",
    "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { silent = true, noremap = true, desc = "Redraw / Clear Hlsearch / Diff Update" }
)
