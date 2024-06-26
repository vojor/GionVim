-- neovim 基础选项设置
-- 日志等级级别："TRACE","DEBUG","INFO","WARN","ERROR","OFF"

------------ 全局设置 ------------
-- 设置 leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- 根目录检测
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
-- 设置 python3_host_prog 地址
vim.g.python3_host_prog = "/usr/bin/python"
-- 设置 lazygit 主题
vim.g.lazygit_config = true
-- 隐藏弃用警告
vim.g.deprecation_warnings = false
-- 修复 markdown 缩进
vim.g.markdown_recommended_style = 0
-- 全局设置 trouble lualine
vim.g.trouble_lualine = true
-- Options for the GionVim statuscolumn
vim.g.gionvim_statuscolumn = {
    folds_open = false,
    folds_githl = false,
}
vim.g.bigfile_size = 1024 * 1024 * 1.5

------------ 选项配置 ------------
-- 控制隐藏文本级别
vim.opt.conceallevel = 2
-- 防止包裹
vim.opt.wrap = false
-- 默认新窗口在右和下
vim.opt.splitright = true
vim.opt.splitbelow = true
-- 拆分文档时行为
vim.opt.splitkeep = "screen"
-- 行号显示 绝对行号和相对行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 显示标尺
vim.opt.ruler = true
-- 无操作时候交换文件写入磁盘等待的时间
vim.opt.updatetime = 200
-- 高亮当前文本行
vim.opt.cursorline = true
-- 等待按键时长的时间
vim.opt.timeout = true
vim.opt.timeoutlen = 500
-- 外部修改时自动加载
vim.opt.autowrite = true
vim.opt.autoread = true
-- 退出时提示确认
vim.opt.confirm = true
-- 编码设置和检测
vim.opt.fileencodings = { "ucs-bom", "utf-8", "utf-16", "utf-32", "gb18030", "gbk", "gb2312", "latin1" }
vim.opt.fileformats = { "unix", "dos" }
-- 显示左侧图标指示列
vim.opt.signcolumn = "yes"
-- 状态指示器
vim.opt.statuscolumn = [[%!v:lua.require'gionvim.util'.ui.statuscolumn()]]
-- 搜索设置
-- -- 搜索忽略大小写
vim.opt.ignorecase = true
-- -- 模式中有大写字母时不忽略大小写
vim.opt.smartcase = true
-- -- 搜索高亮匹配
vim.opt.incsearch = true
-- -- 高亮最近的匹配搜索模式
vim.opt.hlsearch = true
-- 拼写建议
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions:append("noplainbuffer")
-- 鼠标支持
vim.opt.mouse = "a"
-- 启用系统剪切板
vim.opt.clipboard = "unnamedplus"
-- 缓存文件设置
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
-- 显示特殊字符
vim.opt.list = true
-- 使用不可见字符的显示方式
vim.opt.listchars = { space = "·", tab = "▸ ", eol = "↴", trail = "•" }
-- 操作填充字符
vim.opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
-- 终端真颜色支持
vim.opt.termguicolors = true
-- 设置缩进
-- -- 保证在折行时维持缩进不变
vim.opt.breakindent = true
-- -- 根据上一行决定新行的缩进
vim.opt.smartindent = true
-- -- tab 占用的空格数量
vim.opt.tabstop = 4
-- -- 缩进的空白长度指示
vim.opt.shiftwidth = 4
-- -- 编辑时 tab 使用的空格数
vim.opt.softtabstop = 4
-- -- 按下 tab 时替换为空格
vim.opt.expandtab = true
-- -- 缩进列数对齐到 shiftwidth 的整数倍
vim.opt.shiftround = true
-- 插入括号时短暂跳转到另一半括号
vim.opt.showmatch = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.opt.whichwrap = "<,>,[,]"
-- 在视觉块模式下，允许光标在没有文字的地方移动
vim.opt.virtualedit = "block"
-- 补全优化
-- -- 补全菜单背景透明
vim.opt.pumblend = 10
-- -- 补全菜单长度
vim.opt.pumheight = 12
-- -- 'wildchar' 命令行扩展所用的模式
vim.opt.wildmode = "longest:full,full"
-- -- 增强模式的命令行补全
vim.opt.wildmenu = true
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.opt.showmode = false
-- 屏幕重绘时间
vim.opt.redrawtime = 5000
-- 代码折叠
vim.opt.foldenable = true
vim.opt.smoothscroll = true
vim.opt.foldexpr = [[%!v:lua.require'gionvim.util'.ui.foldexpr()]]
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""
-- -- 当前打开文件的折叠级别
vim.opt.foldlevel = 99
-- -- 文件初始打开的折叠级别
vim.opt.foldlevelstart = 99
-- -- 设定指示折叠的列宽度
vim.opt.foldcolumn = "1"
-- 筛选设置
-- -- :grep 使用的程序
-- vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepprg = "ugrep -RInk -j -u --tabs=1 --ignore-files"
-- -- grepprg 输出格式
-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepformat = "%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\|%l\\|%c\\|%m"
-- 格式化行为
vim.opt.formatexpr = "v:lua.require'gionvim.util'.format.formatexpr()"
vim.opt.formatoptions = "jcroqlnt"
-- 会话
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- 短消息显示
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
-- 命令行高度
-- vim.opt.cmdheight = 0
-- 增量预览
vim.opt.inccommand = "nosplit"
-- 可见窗口的顶部和底部之间保留的上下滚动行数
vim.opt.scrolloff = 4
-- 窗口左右保留的字符列数
vim.opt.sidescrolloff = 8
-- 始终显示状态栏，一个文件时自动隐藏
vim.opt.laststatus = 3
-- 窗口最小宽度
vim.opt.winminwidth = 5
