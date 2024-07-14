local M = setmetatable({}, {
    __call = function(m, ...)
        return m.wrap(...)
    end,
})

M.picker = nil

function M.register(picker)
    if vim.v.vim_did_enter == 1 then
        return true
    end

    if M.picker and M.picker.name ~= M.want() then
        M.picker = nil
    end

    if M.picker and M.picker.name ~= picker.name then
        GionVim.warn(
            "`GionVim.pick`: picker already set to `"
                .. M.picker.name
                .. "`,\nignoring new picker `"
                .. picker.name
                .. "`"
        )
        return false
    end
    M.picker = picker
    return true
end

function M.want()
    vim.g.gionvim_picker = vim.g.gionvim_picker or "auto"
    if vim.g.gionvim_picker == "auto" then
        return "telescope"
    end
    return vim.g.gionvim_picker
end

function M.open(command, opts)
    if not M.picker then
        return GionVim.error("GionVim.pick: picker not set")
    end

    command = command ~= "auto" and command or "files"
    opts = opts or {}

    opts = vim.deepcopy(opts)

    if type(opts.cwd) == "boolean" then
        GionVim.warn("GionVim.pick: opts.cwd should be a string or nil")
        opts.cwd = nil
    end

    if not opts.cwd and opts.root ~= false then
        opts.cwd = GionVim.root({ buf = opts.buf })
    end

    command = M.picker.commands[command] or command
    M.picker.open(command, opts)
end

function M.wrap(command, opts)
    opts = opts or {}
    return function()
        GionVim.pick.open(command, vim.deepcopy(opts))
    end
end

function M.config_files()
    return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end

return M
