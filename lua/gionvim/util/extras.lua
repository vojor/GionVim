local M = {}
M.buf = 0

function M.wants(opts)
    if opts.ft then
        opts.ft = type(opts.ft) == "string" and { opts.ft } or opts.ft
        for _, f in ipairs(opts.ft) do
            if vim.bo[M.buf].filetype == f then
                return true
            end
        end
    end
    if opts.root then
        opts.root = type(opts.root) == "string" and { opts.root } or opts.root
        return #GionVim.root.detectors.pattern(M.buf, opts.root) > 0
    end
    return false
end

return M
