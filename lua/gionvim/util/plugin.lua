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
    vim.api.nvim_create_autocmd("BufReadPost", {
        once = true,
        callback = function(event)
            if vim.v.vim_did_enter == 1 then
                return
            end

            local ft = vim.filetype.match({ buf = event.buf })
            if ft then
                local lang = vim.treesitter.language.get_lang(ft)
                if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
                    vim.bo[event.buf].syntax = ft
                end

                vim.cmd([[redraw]])
            end
        end,
    })

    local Event = require("lazy.core.handler.event")

    Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
    Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

return M
