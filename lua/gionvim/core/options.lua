-- Log Level："TRACE","DEBUG","INFO","WARN","ERROR","OFF"

------------ Global Set ------------
-- Root directory detect
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
-- Disable auto format
vim.g.autoformat = false
vim.g.gionvim_picker = "auto"
-- Setting python3_host_prog address
vim.g.python3_host_prog = "/usr/bin/python"
-- Lsp ignore service
vim.g.root_lsp_ignore = { "copilot" }
-- Conceal deprecation warning
vim.g.deprecation_warnings = false
-- Fix markdown indent
vim.g.markdown_recommended_style = 0
-- Setting lualine for trouble
vim.g.trouble_lualine = true

------------ Option Configuration ------------

--------  Basic requirements  --------
-- Text conceal level
vim.opt.conceallevel = 2
-- Prevent wrap
vim.opt.wrap = false
-- Document Split behavior
vim.opt.splitkeep = "screen"
-- Show number and relative number
vim.opt.number = true
vim.opt.relativenumber = true
-- Show ruler
vim.opt.ruler = true
-- File write to disk wait time
vim.opt.updatetime = 200
-- Screen redraw time
vim.opt.redrawtime = 5000
-- Highlight current text line
vim.opt.cursorline = true
-- Continue key and time
vim.opt.timeout = true
vim.opt.timeoutlen = 500
-- Auto loaded when external modify
vim.opt.autowrite = true
vim.opt.autoread = true
-- Exit use confirm
vim.opt.confirm = true

--------  Encoding  --------
-- Encoding set and detect
vim.opt.fileencodings = { "ucs-bom", "utf-8", "utf-16", "utf-32", "gb18030", "gbk", "gb2312", "latin1" }
-- Encoding format
vim.opt.fileformats = { "unix", "dos" }

--------  Search  --------
-- Ignore case
vim.opt.ignorecase = true
-- Mode use capital don't ignore case
vim.opt.smartcase = true
-- Highlight match
vim.opt.incsearch = true
-- Highlight recent matching search patterns
vim.opt.hlsearch = true
-- Increment preview
vim.opt.inccommand = "nosplit"

--------  Spelling  --------
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions:append("noplainbuffer")
-- Support mouse
vim.opt.mouse = "a"
-- Enable system clipboard
vim.opt.clipboard = "unnamedplus"

--------  Backup  --------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000

-------- Character  --------
-- Show special characters
vim.opt.list = true
-- How invisible characters are displayed
vim.opt.listchars = { space = "·", tab = "▸ ", eol = "↴", trail = "•" }
-- Operate fill character
vim.opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }

--------  Indent  --------
-- Keep indentation unchanged
vim.opt.breakindent = true
-- -- 根据上一行决定新行的缩进
vim.opt.smartindent = true
-- -- tab 占用的空格数量
vim.opt.tabstop = 4
-- -- 缩进的空白长度指示
vim.opt.shiftwidth = 4
-- -- 编辑时 tab 使用的空格数
vim.opt.softtabstop = 4
-- Expand tab to space
vim.opt.expandtab = true
-- -- 缩进列数对齐到 shiftwidth 的整数倍
vim.opt.shiftround = true
-- 插入括号时短暂跳转到另一半括号
vim.opt.showmatch = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.opt.whichwrap = "<,>,[,]"
-- 在视觉块模式下，允许光标在没有文字的地方移动
vim.opt.virtualedit = "block"

--------  Completion  --------
-- 补全菜单背景透明
vim.opt.pumblend = 10
-- 补全菜单长度
vim.opt.pumheight = 12
--'wildchar' 命令行扩展所用的模式
vim.opt.wildmode = "longest:full,full"
-- 增强模式的命令行补全
vim.opt.wildmenu = true

--------  Fold  --------
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.require'gionvim.util'.ui.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"

--------  Grep  --------
-- -- “grep" program
-- vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepprg = "ugrep -RInk -j -u --tabs=1 --ignore-files"
-- -- "grep" output format
-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepformat = "%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\|%l\\|%c\\|%m"

--------  Format  --------
-- Format behavior
vim.opt.formatexpr = "v:lua.require'gionvim.util'.format.formatexpr()"
vim.opt.formatoptions = "jcroqlnt"

--------  Message and Session
-- Session option
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- Setting Short Message
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

--------  UI  --------
-- Smooth scroll
vim.opt.smoothscroll = true
-- Show left Sign
vim.opt.signcolumn = "yes"
-- Status instruct
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
-- Terminal color
vim.opt.termguicolors = true
-- Unnecessary Vim mode hint
vim.opt.showmode = false

--------  Window  --------
-- Visible window the top and bottom between remain scroll line
vim.opt.scrolloff = 4
-- Window side reserve character column
vim.opt.sidescrolloff = 8
-- Status line behavior
vim.opt.laststatus = 3
-- Window min width
vim.opt.winminwidth = 5
-- Default new window in blow and right
vim.opt.splitright = true
vim.opt.splitbelow = true
