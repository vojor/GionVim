local M = {}

function M.option(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return GionVim.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            GionVim.info("Enabled " .. option, { title = "Option" })
        else
            GionVim.warn("Disabled " .. option, { title = "Option" })
        end
    end
end

local nu = { number = true, relativenumber = true }
function M.number()
    if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
        nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        GionVim.warn("Disabled line numbers", { title = "Option" })
    else
        vim.opt_local.number = nu.number
        vim.opt_local.relativenumber = nu.relativenumber
        GionVim.info("Enabled line numbers", { title = "Option" })
    end
end

local enabled = true
function M.diagnostics()
    if vim.diagnostic.is_enabled then
        enabled = vim.diagnostic.is_enabled()
    elseif vim.diagnostic.is_disabled then
        enabled = not vim.diagnostic.is_disabled()
    end
    enabled = not enabled

    if enabled then
        vim.diagnostic.enable()
        GionVim.info("Enabled diagnostics", { title = "Diagnostics" })
    else
        vim.diagnostic.disable()
        GionVim.warn("Disabled diagnostics", { title = "Diagnostics" })
    end
end

function M.inlay_hints(buf, value)
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(ih) == "function" then
        ih(buf, value)
    elseif type(ih) == "table" and ih.enable then
        if value == nil then
            value = not ih.is_enabled({ bufnr = buf or 0 })
        end
        ih.enable(value, { bufnr = buf })
    end
end

M._maximized = nil
function M.maximize(state)
    if state == (M._maximized ~= nil) then
        return
    end
    if M._maximized then
        for _, opt in ipairs(M._maximized) do
            vim.o[opt.k] = opt.v
        end
        M._maximized = nil
        vim.cmd("wincmd =")
    else
        M._maximized = {}
        local function set(k, v)
            table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
            vim.o[k] = v
        end
        set("winwidth", 999)
        set("winheight", 999)
        set("winminwidth", 10)
        set("winminheight", 4)
        vim.cmd("wincmd =")
    end
    vim.api.nvim_create_autocmd("ExitPre", {
        once = true,
        group = vim.api.nvim_create_augroup("gionvim_restore_max_exit_pre", { clear = true }),
        desc = "Restore width/height when close Neovim while maximized",
        callback = function()
            M.maximize(false)
        end,
    })
end

setmetatable(M, {
    __call = function(m, ...)
        return m.option(...)
    end,
})

return M
