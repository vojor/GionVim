local M = {}

GionVim.config = M

local defaults = {
    colorscheme = function()
        require("tokyonight").load()
    end,

    icons = {
        misc = {
            dots = "󰇘",
        },
        ft = {
            octo = "",
        },
        dap = {
            Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint = " ",
            BreakpointCondition = " ",
            BreakpointRejected = { " ", "DiagnosticError" },
            LogPoint = ".>",
        },
        diagnostics = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        },
        git = {
            added = " ",
            modified = " ",
            removed = " ",
            gited = "󰊢 ",
            branched = " ",
            conflicted = " ",
            ignored = "◌",
            renamed = "➜",
            signed = "▎",
            staged = "✓",
            unstaged = "✗",
            untracked = "★",
        },
        kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Codeium = "󰘦 ",
            Color = " ",
            Control = " ",
            Collapsed = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Copilot = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Folder = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Keyword = " ",
            Method = "󰊕 ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            String = " ",
            Struct = "󰆼 ",
            TabNine = "󰏚 ",
            Text = " ",
            TypeParameter = " ",
            Unit = " ",
            Value = " ",
            Variable = "󰀫 ",
        },
    },
    kind_filter = {
        default = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },
        markdown = false,
        help = false,
        lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Property",
            "Struct",
            "Trait",
        },
    },
}

local options
local lazy_clipboard

function M.setup(opts)
    options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

    local group = vim.api.nvim_create_augroup("GionVim", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        callback = function()
            if lazy_clipboard ~= nil then
                vim.opt.clipboard = lazy_clipboard
            end
            GionVim.root.setup()

            vim.api.nvim_create_user_command("LazyHealth", function()
                vim.cmd([[Lazy! load all]])
                vim.cmd([[checkhealth]])
            end, { desc = "Load all plugins and run :checkhealth" })

            local health = require("lazy.health")
            vim.list_extend(health.valid, {
                "recommended",
                "desc",
            })
        end,
    })

    GionVim.track("colorscheme")
    GionVim.try(function()
        if type(M.colorscheme) == "function" then
            M.colorscheme()
        else
            vim.cmd.colorscheme(M.colorscheme)
        end
    end, {
        msg = "Could not load your colorscheme",
        on_error = function(msg)
            GionVim.error(msg)
            vim.cmd.colorscheme("habamax")
        end,
    })
    GionVim.track()
end

function M.get_kind_filter(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
    local ft = vim.bo[buf].filetype
    if M.kind_filter == false then
        return
    end
    if M.kind_filter[ft] == false then
        return
    end
    if type(M.kind_filter[ft]) == "table" then
        return M.kind_filter[ft]
    end
    return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
end

function M.load(name)
    local function _load(mod)
        if require("lazy.core.cache").find(mod)[1] then
            GionVim.try(function()
                require(mod)
            end, { msg = "Failed loading " .. mod })
        end
    end
    local pattern = "GionVim" .. name:sub(1, 1):upper() .. name:sub(2)
    if M.defaults[name] or name == "options" then
        _load("gionvim.config." .. name)
        vim.api.nvim_exec_autocmds("User", { pattern = pattern .. "Defaults", modeline = false })
    end
    _load("config." .. name)
    if vim.bo.filetype == "lazy" then
        vim.cmd([[do VimResized]])
    end
    vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
    if M.did_init then
        return
    end
    M.did_init = true

    GionVim.lazy_notify()

    M.load("options")

    lazy_clipboard = vim.opt.clipboard
    vim.opt.clipboard = ""

    if vim.g.deprecation_warnings == false then
        vim.deprecate = function() end
    end

    GionVim.plugin.setup()
end

setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end
        return options[key]
    end,
})

return M
