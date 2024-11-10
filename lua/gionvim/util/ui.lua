local M = {}

function M.foldtext()
    local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
    local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
    if not ret or type(ret) == "string" then
        ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
    end
    table.insert(ret, { " " .. GionConfig.icons.misc.dots })

    if not vim.treesitter.foldtext then
        return table.concat(
            vim.tbl_map(function(line)
                return line[1]
            end, ret),
            " "
        )
    end
    return ret
end

function M.fg(name)
    local color = M.color(name)
    return color and { fg = color } or nil
end

function M.color(name, bg)
    local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
        or vim.api.nvim_get_hl_by_name(name, true)
    local color = nil
    if hl then
        if bg then
            color = hl.bg or hl.background
        else
            color = hl.fg or hl.foreground
        end
    end
    return color and string.format("#%06x", color) or nil
end

M.skip_foldexpr = {}
local skip_check = assert(vim.uv.new_check())

function M.foldexpr()
    local buf = vim.api.nvim_get_current_buf()

    if not vim.b[buf].ts_highlight then
        return "0"
    end

    if M.skip_foldexpr[buf] then
        return "0"
    end

    if vim.bo[buf].buftype == "terminal" then
        return "0"
    end

    if vim.bo[buf].filetype == "" then
        return "0"
    end

    local ok = pcall(vim.treesitter.get_parser, buf)

    if ok then
        return vim.treesitter.foldexpr()
    end

    M.skip_foldexpr[buf] = true
    skip_check:start(function()
        M.skip_foldexpr = {}
        skip_check:stop()
    end)
    return "0"
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
