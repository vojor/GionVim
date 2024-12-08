local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
_G.GionConfig = require("gionvim.config")

require("lazy").setup({
    spec = {
        ---- Basic plugin ----
        { import = "gionvim.plugins" },

        ---- Extras plugin ----
        -- colorscheme
        -- { import = "gionvim.plugins.extras.colorscheme.nightfox" },
        -- dap
        { import = "gionvim.plugins.extras.dap.luadap" }, -- Neovim lua debug
        -- develop
        { import = "gionvim.plugins.extras.develop.comments" }, -- Quick comment
        { import = "gionvim.plugins.extras.develop.compiler" }, -- Code build and run
        { import = "gionvim.plugins.extras.develop.commander" }, -- Find plugin keymaps
        { import = "gionvim.plugins.extras.develop.lazydev" }, -- lua development
        { import = "gionvim.plugins.extras.develop.refactor" }, -- Refactor code
        -- diagnostics
        { import = "gionvim.plugins.extras.diagnostics.trouble" }, -- Look diagnostics result
        -- editor
        { import = "gionvim.plugins.extras.editor.autotools" }, -- Auto pairs and save
        { import = "gionvim.plugins.extras.editor.portal" }, -- Local list navigate
        { import = "gionvim.plugins.extras.editor.replacer" }, -- Factor replace
        { import = "gionvim.plugins.extras.editor.surround" }, -- Surround modify
        -- elevate
        { import = "gionvim.plugins.extras.elevate.escape" }, -- More user-friendly mode switching
        { import = "gionvim.plugins.extras.elevate.scope" }, -- Enhance Buffer scope
        { import = "gionvim.plugins.extras.elevate.scroll" }, -- Smooth scrolling
        { import = "gionvim.plugins.extras.elevate.substitute" }, -- Replace Neovim built-in 'substitute'
        -- explorer
        { import = "gionvim.plugins.extras.explorer" }, -- More explorer
        -- git
        { import = "gionvim.plugins.extras.git.diffview" }, -- Git history difference
        { import = "gionvim.plugins.extras.git.neogit" }, -- Neovim's magit
        -- labeler
        { import = "gionvim.plugins.extras.labeler.arrow" }, -- File mark
        { import = "gionvim.plugins.extras.labeler.marks" }, -- Line mark
        -- lsp
        -- -- lang
        { import = "gionvim.plugins.extras.lsp.langlarge.clangd" }, -- C/C++
        -- { import = "gionvim.plugins.extras.lsp.langlarge.java" }, -- Java
        { import = "gionvim.plugins.extras.lsp.langlarge.jqx" }, -- Json/Yaml
        { import = "gionvim.plugins.extras.lsp.langlarge.markdown" }, -- Markdown
        { import = "gionvim.plugins.extras.lsp.langlarge.typescript" }, -- Javascript/Typescript
        -- -- util
        -- { import = "gionvim.plugins.extras.lsp.boost.better-diagnostic-virtual-text" }, -- improve diagnostic virtual text
        { import = "gionvim.plugins.extras.lsp.boost.dropbar" }, -- Code navigate
        { import = "gionvim.plugins.extras.lsp.boost.fidget" }, -- Progress prompt
        { import = "gionvim.plugins.extras.lsp.boost.garbage" }, -- Disable unfocused serve
        { import = "gionvim.plugins.extras.lsp.boost.illuminate" }, -- Display the same vocabulary under the cursor
        { import = "gionvim.plugins.extras.lsp.boost.increname" }, -- Timely feedback rename
        { import = "gionvim.plugins.extras.lsp.boost.lspsaga" }, -- Strengthen LSP experience
        { import = "gionvim.plugins.extras.lsp.boost.naybuddy" }, -- Float navigate
        { import = "gionvim.plugins.extras.lsp.boost.outline" }, -- Symbols Outline
        -- seek
        { import = "gionvim.plugins.extras.seek.fzf" }, -- fuzzy find
        -- treesitter
        { import = "gionvim.plugins.extras.treesitter.autotag" }, -- Auto close tag
        { import = "gionvim.plugins.extras.treesitter.context" }, -- Code context
        { import = "gionvim.plugins.extras.treesitter.textobjects" }, -- Code text objects
        { import = "gionvim.plugins.extras.treesitter.treesj" }, -- Splitting or merging code
        -- ui
        { import = "gionvim.plugins.extras.ui.colorizer" }, -- Display hexadecimal colors
        { import = "gionvim.plugins.extras.ui.edgy" }, -- Predefined layout
        { import = "gionvim.plugins.extras.ui.hlslens" }, -- Highlight entries during search
        { import = "gionvim.plugins.extras.ui.indentstyle" }, -- Indent format
        { import = "gionvim.plugins.extras.ui.rainbow" }, -- Rainbow brackets
        -- utils
        { import = "gionvim.plugins.extras.utils.dot" }, -- Add more file types
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
