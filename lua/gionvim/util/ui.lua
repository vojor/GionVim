local M = {}

function M.foldtext()
    return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end

function M.foldexpr()
    local buf = vim.api.nvim_get_current_buf()
    if vim.b[buf].ts_folds == nil then
        if vim.bo[buf].filetype == "" then
            return "0"
        end
        vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
    return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

function M.fg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    local fg = hl and hl.fg or hl.foreground
    return fg and { fg = string.format("#%06x", fg) } or nil
end

function M.maximize()
    local maximized = nil
    return Snacks.toggle({
        name = "Maximize",
        get = function()
            return maximized ~= nil
        end,
        set = function(state)
            if state then
                maximized = {}
                local function set(k, v)
                    table.insert(maximized, 1, { k = k, v = vim.o[k] })
                    vim.o[k] = v
                end
                set("winwidth", 999)
                set("winheight", 999)
                set("winminwidth", 10)
                set("winminheight", 4)
                vim.cmd("wincmd =")
                vim.api.nvim_create_autocmd("ExitPre", {
                    once = true,
                    group = vim.api.nvim_create_augroup("gionvim_restore_max_exit_pre", { clear = true }),
                    desc = "Restore width/height when close Neovim while maximized",
                    callback = function()
                        M.maximize.set(false)
                    end,
                })
            else
                for _, opt in ipairs(maximized) do
                    vim.o[opt.k] = opt.v
                end
                maximized = nil
                vim.cmd("wincmd =")
            end
        end,
    })
end

return M
