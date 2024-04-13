local M = {}

GionVim.config = M

local defaults = {
    colorscheme = function()
        require("tokyonight").load()
    end,
}

M.filter = {
    kind_filter = {
        default = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },
        markdown = false,
        help = false,
        lua = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Property",
            "Struct",
            "Trait",
        },
    },
}

local options

function M.setup(opts)
    options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

    for name, icon in pairs(require("core.icons").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end

    local group = vim.api.nvim_create_augroup("GionVim", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        callback = function()
            GionVim.root.setup()
        end,
    })

    GionVim.track("colorscheme")
    GionVim.try(function()
        if type(M.colorscheme) == "function" then
            M.colorscheme()
        else
            vim.cmd.colorscheme(M.colorscheme)
        end
    end, {
        msg = "Could not load your colorscheme",
        on_error = function(msg)
            GionVim.error(msg)
            vim.cmd.colorscheme("habamax")
        end,
    })
    GionVim.track()
end

function M.get_kind_filter(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
    local ft = vim.bo[buf].filetype
    if M.filter.kind_filter == false then
        return
    end
    if M.filter.kind_filter[ft] == false then
        return
    end
    if type(M.filter.kind_filter[ft]) == "table" then
        return M.filter.kind_filter[ft]
    end
    return type(M.filter.kind_filter) == "table"
            and type(M.filter.kind_filter.default) == "table"
            and M.filter.kind_filter.default
        or nil
end

setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end
        return options[key]
    end,
})

return M
