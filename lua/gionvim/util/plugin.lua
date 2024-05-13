local M = {}

M.use_lazy_file = true
M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

function M.setup()
    M.lazy_file()
end

function M.lazy_file()
    M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0

    local Event = require("lazy.core.handler.event")

    if M.use_lazy_file then
        Event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
        Event.mappings["User LazyFile"] = Event.mappings.LazyFile
    else
        Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
        Event.mappings["User LazyFile"] = Event.mappings.LazyFile
        return
    end

    local events = {}

    local done = false
    local function load()
        if #events == 0 or done then
            return
        end
        done = true
        vim.api.nvim_del_augroup_by_name("lazy_file")

        local skips = {}
        for _, event in ipairs(events) do
            local augroups = Event.get_augroups(event.event)
            local groups = vim.tbl_filter(function(t)
                return not vim.tbl_contains({ t }, "filetypedetect")
            end, augroups)
            skips[event.event] = skips[event.event] or groups
        end

        vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
        for _, event in ipairs(events) do
            if vim.api.nvim_buf_is_valid(event.buf) then
                Event.trigger({
                    event = event.event,
                    exclude = skips[event.event],
                    data = event.data,
                    buf = event.buf,
                })
                if vim.bo[event.buf].filetype then
                    Event.trigger({
                        event = "FileType",
                        buf = event.buf,
                    })
                end
            end
        end
        vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
        events = {}
    end

    load = vim.schedule_wrap(load)

    vim.api.nvim_create_autocmd(M.lazy_file_events, {
        group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
        callback = function(event)
            table.insert(events, event)
            load()
        end,
    })
end

return M
