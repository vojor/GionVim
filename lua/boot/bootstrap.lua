local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        ---- 导入基础插件 ----
        { import = "plugins" },
        ---- 导入额外扩展插件 ----
        -- colorscheme
        -- { import = "plugins.extras.colorscheme.kanagawa" },
        -- { import = "plugins.extras.colorscheme.monokaipro" },
        -- { import = "plugins.extras.colorscheme.nightfox" },
        -- { import = "plugins.extras.colorscheme.onenord" },
        -- dap
        { import = "plugins.extras.dap.luadap" }, -- 特定语言调试插件
        -- develop
        { import = "plugins.extras.develop.bigfile" }, -- 大文件控制
        { import = "plugins.extras.develop.comments" }, -- 快速注释
        { import = "plugins.extras.develop.compiler" }, -- 构建和运行代码
        { import = "plugins.extras.develop.font-icon" }, -- 图标选择
        { import = "plugins.extras.develop.commander" }, -- 查找命令以及按键绑定
        -- diagnostics
        { import = "plugins.extras.diagnostics.trouble" }, -- 代码诊断结果
        -- editor
        { import = "plugins.extras.editor.autotools" }, -- 自动处理工具
        { import = "plugins.extras.editor.replacer" }, -- 参数替换
        { import = "plugins.extras.editor.portal" }, -- 位置列表导航
        { import = "plugins.extras.editor.surround" }, -- 修改定界符
        -- { import = "plugins.extras.editor.coerce" }, -- 更改关键词大小写
        -- { import = "plugins.extras.develop.refactor" }, -- 代码重构
        -- elevate
        { import = "plugins.extras.elevate.scope" }, -- 增强选项卡范围
        { import = "plugins.extras.elevate.escape" }, -- 更好的模式切换
        { import = "plugins.extras.elevate.scroll" }, -- 平滑滚动
        { import = "plugins.extras.elevate.substitute" }, -- 代替内置 substitute
        -- explorer
        { import = "plugins.extras.explorer" }, -- 更多文件浏览工具
        -- git
        { import = "plugins.extras.git" }, -- 优秀 git 工具
        -- labeler
        { import = "plugins.extras.labeler.harpoon" }, -- 文件标记
        { import = "plugins.extras.labeler.marks" }, -- 行标记
        -- { import = "plugins.extras.labeler.trailblazer" }, -- 字符标记
        -- line
        -- { import = "plugins.extras.line.sideline" }, -- 侧边栏
        -- { import = "plugins.extras.line.statusLine" }, -- 状态栏
        -- { import = "plugins.extras.line.tabline" }, -- tabline
        -- lsp lang
        { import = "plugins.extras.lsp.lang.clangd" },
        -- { import = "plugins.extras.lsp.lang.java" },
        { import = "plugins.extras.lsp.lang.jqx" },
        { import = "plugins.extras.lsp.lang.typescript" },
        -- lsp strength
        { import = "plugins.extras.lsp.reinforce.aerial" }, -- 代码大纲
        -- { import = "plugins.extras.lsp.reinforce.dropbar" }, -- 代码导航
        { import = "plugins.extras.lsp.reinforce.fidget" }, -- LSP 进度提示
        { import = "plugins.extras.lsp.reinforce.illuminate" }, -- 显示光标下相同词汇
        { import = "plugins.extras.lsp.reinforce.increname" }, -- 基于 LSP 带有即时视觉反馈的重命名
        { import = "plugins.extras.lsp.reinforce.lspsaga" }, -- 改善 Neovim LSP 体验
        { import = "plugins.extras.lsp.reinforce.naybuddy" }, -- 浮动导航窗口
        { import = "plugins.extras.lsp.reinforce.outline" }, -- 符号大纲
        -- search
        { import = "plugins.extras.fzf" }, -- fzf 搜索
        -- treesitter
        { import = "plugins.extras.treesitter.treesj" }, -- 分割/合并代码
        { import = "plugins.extras.treesitter.context" }, -- 上下文环境
        { import = "plugins.extras.treesitter.autotag" }, -- 自动关闭标签
        { import = "plugins.extras.treesitter.commentstring" }, -- 注释
        -- ui
        -- { import = "plugins.extras.ui.alpha" },
        -- { import = "plugins.extras.ui.starter" },
        { import = "plugins.extras.ui.dashboard" }, -- 启动界面
        -- { import = "plugins.extras.ui.animate" }, -- 动画效果
        -- { import = "plugins.extras.ui.annotbox" }, -- 注释美化
        { import = "plugins.extras.ui.colorizer" }, -- 16 进制颜色
        { import = "plugins.extras.ui.edgy" }, -- 预定义布局
        { import = "plugins.extras.ui.hlslens" }, -- 搜索高亮条目
        { import = "plugins.extras.ui.rainbow" }, -- 彩虹括号
        { import = "plugins.extras.ui.indentstyle" }, -- 缩进样式
        -- utils
        { import = "plugins.extras.utils.startuptime" }, -- 测量启动时间
    },
    defaults = { version = false },
    install = { colorscheme = { "tokyonight", "nightfox", "habamax" } },
    ui = {
        border = "rounded",
        icons = {
            ft = "",
            loaded = "",
            not_loaded = "",
        },
    },
    custom_keys = {
        ["<localleader>l"] = false,
        ["<localleader>t"] = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "bugreport",
                "compiler",
                "editorconfig",
                "ftplugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logiPat",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "netrwSettings",
                "optwin",
                "remote_plugins",
                "rplugin",
                "rrhelper",
                "shada",
                "shada_plugin",
                "spellfile",
                "spellfile_plugin",
                "synmenu",
                "syntax",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "tutor_mode_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            },
        },
    },
})

-- 配置全局可调用配置
_G.GionVim = require("config.util")
