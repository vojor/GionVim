local M = {}

M.moved = {
    lsp = {
        rename_file = { "Snacks.rename.rename_file" },
        on_rename = { "Snacks.rename.on_rename_file" },
        words = { "Snacks.words" },
        on_supports_method = {
            "Snacks.util.lsp.on",
            fn = function(method, cb)
                return Snacks.util.lsp.on({ method = method }, function(buffer, client)
                    cb(client, buffer)
                end)
            end,
        },
        on_attach = {
            "Snacks.util.lsp.on",
            fn = function(cb, name)
                return Snacks.util.lsp.on({ name = name }, function(buffer, client)
                    cb(client, buffer)
                end)
            end,
        },
    },
    terminal = {
        open = { "Snacks.terminal" },
        __call = { "Snacks.terminal" },
    },
    ui = {
        statuscolumn = { "Snacks.statuscolumn" },
        bufremove = { "Snacks.bufdelete" },
        foldexpr = { "GionVim.treesitter.foldexpr", stacktrace = false },
        fg = {
            "{ fg = Snacks.util.color(...) }",
            fn = function(...)
                return { fg = Snacks.util.color(...) }
            end,
        },
    },
}

function M.decorate(name, mod)
    if not M.moved[name] then
        return mod
    end
    return setmetatable(mod, {
        __call = function(_, ...)
            local to = M.moved[name].__call[1]
            GionVim.deprecate("GionVim." .. name, to)
            local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
            return ret(...)
        end,
        __index = function(_, k)
            if M.moved[name][k] then
                local to = M.moved[name][k][1]
                GionVim.deprecate("GionVim." .. name .. "." .. k, to, {
                    stacktrace = M.moved[name][k].stacktrace,
                })
                if M.moved[name][k].fn then
                    return M.moved[name][k].fn
                end
                local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
                return ret
            end
            return nil
        end,
    })
end

function M.lazygit()
    GionVim.deprecate("GionVim.lazygit", "Snacks.lazygit")
    return Snacks.lazygit
end

function M.ui()
    return M.decorate("ui", {})
end

function M.toggle()
    GionVim.deprecate("GionVim.toggle", "Snacks.toggle")
    return {
        map = function() end,
        wrap = function()
            return {}
        end,
    }
end

return M
