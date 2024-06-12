local M = setmetatable({}, {
    __call = function(m, ...)
        return m.telescope(...)
    end,
})

function M.open(builtin, opts)
    opts = opts or {}
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
        local function open_cwd_dir()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            GionVim.pick.open(
                builtin,
                vim.tbl_deep_extend("force", {}, opts or {}, {
                    root = false,
                    default_text = line,
                })
            )
        end
        opts.attach_mappings = function(_, map)
            map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
            return true
        end
    end

    require("telescope.builtin")[builtin](opts)
end

M.telescope = function(...)
    GionVim.deprecate("GionVim.telescope", "GionVim.pick")
    return GionVim.pick.wrap(...)
end

function M.config_files()
    return GionVim.pick.config_files()
end

return M
