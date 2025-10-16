local M = {}

M._installed = nil
M._queries = {}

function M.get_installed(update)
    if update then
        M._installed, M._queries = {}, {}
        for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
            M._installed[lang] = true
        end
    end
    return M._installed or {}
end

function M.have_query(lang, query)
    local key = lang .. ":" .. query
    if M._queries[key] == nil then
        M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
    end
    return M._queries[key]
end

function M.have(what, query)
    what = what or vim.api.nvim_get_current_buf()
    what = type(what) == "number" and vim.bo[what].filetype or what
    local lang = vim.treesitter.language.get_lang(what)
    if lang == nil or M.get_installed()[lang] == nil then
        return false
    end
    if query and not M.have_query(lang, query) then
        return false
    end
    return true
end

function M.foldexpr()
    return M.have(nil, "folds") and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
    return M.have(nil, "indents") and require("nvim-treesitter").indentexpr() or -1
end

local function win_find_cl()
    local path = "C:/Program Files (x86)/Microsoft Visual Studio"
    local pattern = "*/*/VC/Tools/MSVC/*/bin/Hostx64/x64/cl.exe"
    return vim.fn.globpath(path, pattern, true, true)[1]
end

function M.check()
    local is_win = vim.fn.has("win32") == 1
    local function have(tool, win)
        return (win == nil or is_win == win) and vim.fn.executable(tool) == 1
    end

    local have_cc = vim.env.CC ~= nil or have("cc", false) or have("cl", true) or (is_win and win_find_cl() ~= nil)

    if not have_cc and is_win and vim.fn.executable("gcc") == 1 then
        vim.env.CC = "gcc"
        have_cc = true
    end

    local ret = {
        ["tree-sitter (CLI)"] = have("tree-sitter"),
        ["C compiler"] = have_cc,
        tar = have("tar"),
        curl = have("curl"),
        node = have("node"),
    }
    local ok = true
    for _, v in pairs(ret) do
        ok = ok and v
    end
    return ok, ret
end

function M.build(cb)
    M.ensure_treesitter_cli(function(_, err)
        local ok, health = M.check()
        if ok then
            return cb()
        else
            local lines = { "Unmet requirements for **nvim-treesitter** `main`:" }
            local keys = vim.tbl_keys(health)
            table.sort(keys)
            for _, k in pairs(keys) do
                lines[#lines + 1] = ("- %s `%s`"):format(health[k] and "✅" or "❌", k)
            end
            vim.list_extend(lines, {
                "",
                "See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)",
                "Run `:checkhealth nvim-treesitter` for more information.",
            })
            if vim.fn.has("win32") == 1 and not health["C compiler"] then
                lines[#lines + 1] =
                    "Install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`"
            end
            vim.list_extend(lines, err and { "", err } or {})
            GionVim.error(lines, { title = "GionVim Treesitter" })
        end
    end)
end

function M.ensure_treesitter_cli(cb)
    if vim.fn.executable("tree-sitter") == 1 then
        return cb(true)
    end

    if not pcall(require, "mason") then
        return cb(false, "`mason.nvim` is disabled in your config, so we cannot install it automatically.")
    end

    if vim.fn.executable("tree-sitter") == 1 then
        return cb(true)
    end

    local mr = require("mason-registry")
    mr.refresh(function()
        local p = mr.get_package("tree-sitter-cli")
        if not p:is_installed() then
            GionVim.info("Installing `tree-sitter-cli` with `mason.nvim`...")
            p:install(
                nil,
                vim.schedule_wrap(function(success)
                    if success then
                        GionVim.info("Installed `tree-sitter-cli` with `mason.nvim`.")
                        cb(true)
                    else
                        cb(false, "Failed to install `tree-sitter-cli` with `mason.nvim`.")
                    end
                end)
            )
        end
    end)
end

return M
