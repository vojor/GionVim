local LazyUtil = require("lazy.core.util")

local M = {}

local deprecated = {
    get_clients = "lsp",
    on_attach = "lsp",
    on_rename = "lsp",
    root_patterns = { "root", "patterns" },
    get_root = { "root", "get" },
    float_term = { "terminal", "open" },
    toggle_diagnostics = { "toggle", "diagnostics" },
    toggle_number = { "toggle", "number" },
    fg = "ui",
}

setmetatable(M, {
    __index = function(t, k)
        if LazyUtil[k] then
            return LazyUtil[k]
        end
        local dep = deprecated[k]
        if dep then
            local mod = type(dep) == "table" and dep[1] or dep
            local key = type(dep) == "table" and dep[2] or k
            M.deprecate([[GionVim.]] .. k, [[GionVim.]] .. mod .. "." .. key)
            t[mod] = require("gionvim.util." .. mod)
            return t[mod][key]
        end
        t[k] = require("gionvim.util." .. k)
        return t[k]
    end,
})

function M.is_win()
    return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

function M.get_plugin(name)
    return require("lazy.core.config").spec.plugins[name]
end

function M.get_plugin_path(name, path)
    local plugin = M.get_plugin(name)
    path = path and "/" .. path or ""
    return plugin and (plugin.dir .. path)
end

function M.has(plugin)
    return M.get_plugin(plugin) ~= nil
end

function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

function M.extend(t, key, values)
    local keys = vim.split(key, ".", { plain = true })
    for i = 1, #keys do
        local k = keys[i]
        t[k] = t[k] or {}
        if type(t) ~= "table" then
            return
        end
        t = t[k]
    end
    return vim.list_extend(t, values)
end

function M.opts(name)
    local plugin = require("lazy.core.config").spec.plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

function M.deprecate(old, new)
    M.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), {
        title = "GionVim",
        once = true,
        stacktrace = true,
        stacklevel = 6,
    })
end

function M.lazy_notify()
    local notifs = {}
    local function temp(...)
        table.insert(notifs, vim.F.pack_len(...))
    end

    local orig = vim.notify
    vim.notify = temp

    local timer = vim.uv.new_timer()
    local check = assert(vim.uv.new_check())

    local replay = function()
        timer:stop()
        check:stop()
        if vim.notify == temp then
            vim.notify = orig
        end
        vim.schedule(function()
            for _, notif in ipairs(notifs) do
                vim.notify(vim.F.unpack_len(notif))
            end
        end)
    end

    check:start(function()
        if vim.notify ~= temp then
            replay()
        end
    end)
    timer:start(500, 0, replay)
end

function M.is_loaded(name)
    local Config = require("lazy.core.config")
    return Config.plugins[name] and Config.plugins[name]._.loaded
end

function M.on_load(name, fn)
    if M.is_loaded(name) then
        fn(name)
    else
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            callback = function(event)
                if event.data == name then
                    fn(name)
                    return true
                end
            end,
        })
    end
end

function M.safe_keymap_set(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    local modes = type(mode) == "string" and { mode } or mode

    modes = vim.tbl_filter(function(m)
        return not (keys.have and keys:have(lhs, m))
    end, modes)

    if #modes > 0 then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap then
            opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

function M.dedup(list)
    local ret = {}
    local seen = {}
    for _, v in ipairs(list) do
        if not seen[v] then
            table.insert(ret, v)
            seen[v] = true
        end
    end
    return ret
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
    if vim.api.nvim_get_mode().mode == "i" then
        vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
    end
end

function M.get_pkg_path(pkg, path, opts)
    pcall(require, "mason")
    local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
    opts = opts or {}
    opts.warn = opts.warn == nil and true or opts.warn
    path = path or ""
    local ret = root .. "/packages/" .. pkg .. "/" .. path
    if opts.warn and not vim.loop.fs_stat(ret) and not require("lazy.core.config").headless() then
        M.warn(
            ("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(
                pkg,
                path
            )
        )
    end
    return ret
end

for _, level in ipairs({ "info", "warn", "error" }) do
    M[level] = function(msg, opts)
        opts = opts or {}
        opts.title = opts.title or "GionVim"
        return LazyUtil[level](msg, opts)
    end
end

return M
