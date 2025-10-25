local M = {}

function M.formatter(opts)
    opts = opts or {}
    local filter = opts.filter or {}
    filter = type(filter) == "string" and { name = filter } or filter
    local ret = {
        name = "LSP",
        primary = true,
        priority = 1,
        format = function(buf)
            M.format(GionVim.merge({}, filter, { bufnr = buf }))
        end,
        sources = function(buf)
            local clients = vim.lsp.get_clients(GionVim.merge({}, filter, { bufnr = buf }))
            local ret = vim.tbl_filter(function(client)
                return client:supports_method("textDocument/formatting")
                    or client:supports_method("textDocument/rangeFormatting")
            end, clients)
            return vim.tbl_map(function(client)
                return client.name
            end, ret)
        end,
    }
    return GionVim.merge(ret, opts)
end

function M.format(opts)
    opts = vim.tbl_deep_extend(
        "force",
        {},
        opts or {},
        GionVim.opts("nvim-lspconfig").format or {},
        GionVim.opts("conform.nvim").format or {}
    )
    local ok, conform = pcall(require, "conform")
    if ok then
        opts.formatters = {}
        conform.format(opts)
    else
        vim.lsp.buf.format(opts)
    end
end

M.action = setmetatable({}, {
    __index = function(_, action)
        return function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    only = { action },
                    diagnostics = {},
                },
            })
        end
    end,
})

function M.execute(opts)
    local params = {
        command = opts.command,
        arguments = opts.arguments,
    }
    if opts.open then
        require("trouble").open({
            mode = "lsp_command",
            params = params,
        })
    else
        return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
    end
end

return M
