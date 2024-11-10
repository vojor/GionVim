local M = {}

M.core_imports = {}

M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

M.deprecated_modules = {}

function M.save_core()
    if vim.v.vim_did_enter == 1 then
        return
    end
    M.core_imports = vim.deepcopy(require("lazy.core.config").spec.modules)
end

function M.setup()
    M.lazy_file()
end

function M.lazy_file()
    local Event = require("lazy.core.handler.event")

    Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
    Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

return M
