local M = setmetatable({}, {
    __call = function(m, ...)
        return m.wrap(...)
    end,
})

M.commands = {
    files = "find_files",
}

function M.open(command, opts)
    command = command or "auto"
    opts = opts or {}

    opts = vim.deepcopy(opts)

    if type(opts.cwd) == "boolean" then
        GionVim.warn("GionVim.pick: opts.cwd should be a string or nil")
        opts.cwd = nil
    end

    if not opts.cwd and opts.root ~= false then
        opts.cwd = GionVim.root({ buf = opts.buf })
    end

    local cwd = opts.cwd or vim.uv.cwd()
    if command == "auto" then
        command = "files"
        if
            vim.uv.fs_stat(cwd .. "/.git")
            and not vim.uv.fs_stat(cwd .. "/.ignore")
            and not vim.uv.fs_stat(cwd .. "/.rgignore")
        then
            command = "git_files"
            opts.show_untracked = opts.show_untracked ~= false
        end
    end
    command = M.commands[command] or command
    M._open(command, opts)
end

function M.wrap(command, opts)
    opts = opts or {}
    return function()
        M.open(command, vim.deepcopy(opts))
    end
end

function M._open(command, opts)
    return GionVim.telescope.open(command, opts)
end

function M.config_files()
    return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end

return M
