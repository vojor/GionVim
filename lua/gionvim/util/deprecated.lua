local M = {}

M.moved = {
    lsp = {
        rename_file = { "Snacks.rename.rename_file" },
        on_rename = { "Snacks.rename.on_rename_file" },
        words = { "Snacks.words" },
    },
    terminal = {
        open = { "Snacks.terminal" },
        __call = { "Snacks.terminal" },
    },
    ui = {
        statuscolumn = { "Snacks.statuscolumn" },
        bufremove = { "Snacks.bufdelete" },
    },
}

function M.decorate(name, mod)
    if not M.moved[name] then
        return mod
    end
    setmetatable(mod, {
        __call = function(_, ...)
            local to = M.moved[name].__call[1]
            GionVim.deprecate("GionVim." .. name, to)
            local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
            return ret(...)
        end,
        __index = function(_, k)
            if M.moved[name][k] then
                local to = M.moved[name][k][1]
                GionVim.deprecate("GionVim." .. name .. "." .. k, to)
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
