local M = {}

M._installed = nil

function M.get_installed(update)
    if update then
        M._installed = {}
        for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
            M._installed[lang] = lang
        end
    end
    return M._installed or {}
end

function M.have(what)
    what = what or vim.api.nvim_get_current_buf()
    what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
    local lang = vim.treesitter.language.get_lang(what)
    return lang ~= nil and M.get_installed()[lang] ~= nil
end

function M.foldexpr()
    return M.have() and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
    return M.have() and require("nvim-treesitter").indentexpr() or -1
end

function M.ensure_treesitter_cli(cb)
    if vim.fn.executable("tree-sitter") == 1 then
        return cb()
    end

    local function fail(msg)
        return GionVim.error({
            "**treesitter-nvim** `main` requires the `tree-sitter` CLI executable to be installed.",
            "Please install it manually from https://github.com/tree-sitter/tree-sitter/tree/master/crates/cli or",
            "use your system package manager.",
            "Run `:checkhealth nvim-treesitter` for more information.",
            msg,
        })
    end

    if not pcall(require, "mason") then
        return fail("`mason.nvim` is disabled in your config, so we cannot install it automatically.")
    end

    if vim.fn.executable("tree-sitter") == 1 then
        return cb()
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
                        cb()
                    else
                        fail("Failed to install `tree-sitter-cli` with `mason.nvim`.")
                    end
                end)
            )
        end
    end)
end

return M
