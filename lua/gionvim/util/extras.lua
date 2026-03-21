local GionConfig = require("lazy.core.config")

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

function M.get()
    M.state = M.state or GionConfig.spec.modules
    local extras = {}
    for _, source in ipairs(M.sources) do
        local root = GionVim.find_root(source.module)
        if root then
            GionVim.walk(root, function(path, name, type)
                if (type == "file" or type == "link") and name:match("%.lua$") then
                    name = path:sub(#root + 2, -5):gsub("/", "."):gsub("%.init$", "")
                    local ok, extra = pcall(M.get_extra, source, source.module .. "." .. name)
                    if ok then
                        extras[#extras + 1] = extra
                    end
                end
            end)
        end
    end
    table.sort(extras, function(a, b)
        return a.name < b.name
    end)
    return extras
end

return M
