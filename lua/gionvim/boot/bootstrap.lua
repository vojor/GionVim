local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

_G.gionvim_docs = true
_G.GionVim = require("gionvim.util")

require("lazy").setup({
    spec = {
        ---- Basic plugin ----
        { import = "gionvim.plugins" },

        ---- Extra plugins ----
        -- colorscheme
        { import = "gionvim.plugins.extras.colorscheme.nightfox" }, -- Diverse theme
        -- dap
        { import = "gionvim.plugins.extras.dap.luadap" }, -- Neovim lua debug
        -- develop
        { import = "gionvim.plugins.extras.develop.comments" }, -- Optimize comment
        { import = "gionvim.plugins.extras.develop.overseer" }, -- Code build and run
        { import = "gionvim.plugins.extras.develop.lazydev" }, -- lua develop
        { import = "gionvim.plugins.extras.develop.refactor" }, -- Refactor code
        { import = "gionvim.plugins.extras.develop.scissors" }, -- Snippets editing
        -- diagnostics
        { import = "gionvim.plugins.extras.diagnostics.trouble" }, -- Look better diagnostics result
        { import = "gionvim.plugins.extras.diagnostics.tiny" }, -- Tiny diagnostics and code action
        -- editor
        { import = "gionvim.plugins.extras.editor.autotools" }, -- Auto pairs and save
        { import = "gionvim.plugins.extras.editor.multicursor" }, -- Multiple cursor
        { import = "gionvim.plugins.extras.editor.portal" }, -- Local list navigate
        { import = "gionvim.plugins.extras.editor.replacer" }, -- Factor replace
        { import = "gionvim.plugins.extras.editor.surround" }, -- Tackle surround
        -- elevate
        { import = "gionvim.plugins.extras.elevate.escape" }, -- More user-friendly mode switching
        { import = "gionvim.plugins.extras.elevate.substitute" }, -- Replace Neovim built-in 'substitute'
        -- explorer
        { import = "gionvim.plugins.extras.explorer.mini-files" }, -- More explorer
        -- git
        { import = "gionvim.plugins.extras.git.diffview" }, -- Git history differ view
        { import = "gionvim.plugins.extras.git.neogit" }, -- Neovim's magit
        -- labeler
        { import = "gionvim.plugins.extras.labeler.arrow" }, -- File and buffer mark
        { import = "gionvim.plugins.extras.labeler.marks" }, -- Line mark
        -- lsp
        -- -- lang extension
        { import = "gionvim.plugins.extras.langext.clangd" }, -- C and C++
        { import = "gionvim.plugins.extras.langext.java" }, -- Java
        { import = "gionvim.plugins.extras.langext.jqx" }, -- Json and Yaml
        { import = "gionvim.plugins.extras.langext.markdown" }, -- Markdown
        { import = "gionvim.plugins.extras.langext.pyvenv" }, -- Python
        { import = "gionvim.plugins.extras.langext.sqls" }, -- SQL and MySQL
        { import = "gionvim.plugins.extras.langext.typescript" }, -- Javascript and Typescript
        -- -- rise capacity
        { import = "gionvim.plugins.extras.boast.dropbar" }, -- Code navigate
        { import = "gionvim.plugins.extras.boast.fidget" }, -- Progress prompt
        { import = "gionvim.plugins.extras.boast.garbage" }, -- Disable unfocused serve
        { import = "gionvim.plugins.extras.boast.illuminate" }, -- Display the same vocabulary under the cursor
        { import = "gionvim.plugins.extras.boast.increname" }, -- Timely feedback rename
        { import = "gionvim.plugins.extras.boast.lspsaga" }, -- Strengthen LSP experience
        { import = "gionvim.plugins.extras.boast.navbuddy" }, -- Float navigate
        { import = "gionvim.plugins.extras.boast.namu" }, -- Symbols jump
        { import = "gionvim.plugins.extras.boast.outline" }, -- Symbols Outline
        -- seek
        { import = "gionvim.plugins.extras.seek.fzf" }, -- fuzzy find
        -- treesitter
        { import = "gionvim.plugins.extras.treesitter.autotag" }, -- Auto close tag
        { import = "gionvim.plugins.extras.treesitter.context" }, -- Code context
        { import = "gionvim.plugins.extras.treesitter.textobjects" }, -- Code text objects
        { import = "gionvim.plugins.extras.treesitter.treesj" }, -- Splitting and merging code
        { import = "gionvim.plugins.extras.treesitter.endwise" }, -- Wise add 'end'
        -- ui
        { import = "gionvim.plugins.extras.ui.colorizer" }, -- Exhibit hexadecimal colors
        { import = "gionvim.plugins.extras.ui.edgy" }, -- Predefined layout
        { import = "gionvim.plugins.extras.ui.hlslens" }, -- Highlight entries during search
        { import = "gionvim.plugins.extras.ui.rainbow" }, -- Rainbow brackets
        -- utils
        { import = "gionvim.plugins.extras.utils.chainsaw" }, -- Add log discourse
        { import = "gionvim.plugins.extras.utils.dot" }, -- Add more file type
        { import = "gionvim.plugins.extras.utils.startuptime" }, -- Measure startup time
        { import = "gionvim.plugins.extras.utils.rest" }, -- Http client
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
