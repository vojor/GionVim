local map = GionVim.safe_keymap_set

---- Basic operate ----
-- file command
map("n", "<leader>ce", "<cmd>enew<CR>", { desc = "New File" })
map("n", "<leader>cw", "<cmd>w<CR>", { desc = "Buffer Write File" })
map("n", "<leader>cW", "<cmd>wa<CR>", { desc = "Write All File" })
map("n", "<leader>cE", "<cmd>e!<CR>", { desc = "Revoke all file changes" })
map("n", "<leader>cq", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>cQ", "<cmd>q!<CR>", { desc = "Force Quit" })
map("n", "<leader>cx", "<cmd>x<CR>", { desc = "Save And Quit" })

-- up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- quickfix/locallist
map("n", "<leader>cl", function()
    local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Location List" })
map("n", "<leader>cc", function()
    local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
    end
end, { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- lazy
map("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Open Lazy Manager Interface" })

-- Floating terminal
map("n", "<leader>tl", function()
    Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>tL", function()
    Snacks.terminal(nil, { cwd = GionVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>", function()
    Snacks.terminal(nil, { cwd = GionVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", function()
    Snacks.terminal(nil, { cwd = GionVim.root() })
end, { desc = "which_key_ignore" })

-- terminal mappings
map("t", "<C-/>", "<cmd>close<CR>", { desc = "Hide Terminal" })
map("t", "<C-_>", "<cmd>close<CR>", { desc = "which_key_ignore" })

-- lazygit
map("n", "<leader>glR", function()
    Snacks.lazygit({ cwd = GionVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>glr", function()
    Snacks.lazygit()
end, { desc = "Lazygit (cwd)" })
map({ "n", "x" }, "<leader>glB", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>glY", function()
    Snacks.gitbrowse({
        open = function(url)
            vim.fn.setreg("+", url)
        end,
        notify = false,
    })
end, { desc = "Git Browse (copy)" })

map("n", "<leader>glh", function()
    Snacks.picker.git_log_file()
end, { desc = "Git Current File History" })
map("n", "<leader>gll", function()
    Snacks.picker.git_log({ cwd = GionVim.root.git() })
end, { desc = "Git Log" })
map("n", "<leader>glL", function()
    Snacks.picker.git_log()
end, { desc = "Git Log (cwd)" })

map("n", "<leader>glb", function()
    Snacks.picker.git_log_line()
end, { desc = "Git Blame Line" })

-- toggle options
GionVim.format.snacks_toggle():map("<leader>of")
GionVim.format.snacks_toggle(true):map("<leader>oF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>oL")
Snacks.toggle.diagnostics():map("<leader>od")
Snacks.toggle.line_number():map("<leader>ol")
Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
    :map("<leader>oC")
Snacks.toggle
    .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
    :map("<leader>oA")
Snacks.toggle.treesitter():map("<leader>ot")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ob")
Snacks.toggle.dim():map("<leader>oD")
Snacks.toggle.animate():map("<leader>om")
Snacks.toggle.indent():map("<leader>oi")
Snacks.toggle.scroll():map("<leader>oS")
Snacks.toggle.profiler():map("<leader>op")
Snacks.toggle.profiler_highlights():map("<leader>oH")
if vim.lsp.inlay_hint then
    Snacks.toggle.inlay_hints():map("<leader>oh")
end

-- checkhealth
map("n", "<leader>ch", "<cmd>checkhealth<CR>", { desc = "Neovim Health Check" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<CR>fxa<bs>", { desc = "Add Comment Above" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
    Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<CR>", { desc = "Delete Buffer and Window" })

-- Move to window
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- window
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
Snacks.toggle.zoom():map("<leader>wm"):map("<leader>wZ")
Snacks.toggle.zen():map("<leader>wz")

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })

-- keywordprg
map("n", "<leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg" })

-- search/highlight
map("n", "<leader>se", "/\\<lt>\\><left><left>")
map("n", "<leader>so", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>sO", "<cmd>InspectTree<CR>", { desc = "Inspect Tree" })
map({ "i", "n" }, "<esc>", "<cmd>noh<CR><esc>", { desc = "Escape and clear hlsearch" })
map(
    "n",
    "<leader>hn",
    "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { silent = true, noremap = true, desc = "Redraw / Clear Hlsearch / Diff Update" }
)
map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    GionVim.cmp.actions.snippet_stop()
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
