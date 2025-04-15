-- Log Level："TRACE","DEBUG","INFO","WARN","ERROR","OFF"

------------ Global Set ------------
-- Root directory detect
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
-- Disable auto format
vim.g.autoformat = false
vim.g.gionvim_picker = "auto"
vim.g.snacks_animate = true
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
-- Disable perl provider
vim.g.loaded_perl_provider = 0

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
-- -- Smart indent
vim.opt.smartindent = true
-- -- One tab replace space number
vim.opt.tabstop = 4
-- -- Indent space indicator
vim.opt.shiftwidth = 4
-- -- Editing tab use space number
vim.opt.softtabstop = 4
-- -- Expand tab to space
vim.opt.expandtab = true
-- -- Indent align at 'shiftwidth' integral multiple
vim.opt.shiftround = true
-- Insert bracket transience jump side
vim.opt.showmatch = true
-- Cursor in head or end,allow <Left><Right> jump next line
vim.opt.whichwrap = "<,>,[,]"
-- In visual block mode，allow cursor to move in areas without text
vim.opt.virtualedit = "block"

--------  Completion  --------
-- Po-pup menu transparency
vim.opt.pumblend = 10
-- Po-pup menu max row number
vim.opt.pumheight = 12
-- Curb behavior for command completion
vim.opt.wildmode = "longest:full,full"
-- Strengthen mode command line completion
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
