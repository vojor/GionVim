local M = {}

M.actions = {
    snippet_forward = function()
        if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
                vim.snippet.jump(1)
            end)
            return true
        end
    end,
    snippet_stop = function()
        if vim.snippet then
            vim.snippet.stop()
        end
    end,
}

function M.map(actions, fallback)
    return function()
        for _, name in ipairs(actions) do
            if M.actions[name] then
                local ret = M.actions[name]()
                if ret then
                    return true
                end
            end
        end
        return type(fallback) == "function" and fallback() or fallback
    end
end

function M.snippet_replace(snippet, fn)
    return snippet:gsub("%$%b{}", function(m)
        local n, name = m:match("^%${(%d+):(.+)}$")
        return n and fn({ n = n, text = name }) or m
    end) or snippet
end

function M.snippet_preview(snippet)
    local ok, parsed = pcall(function()
        return vim.lsp._snippet_grammar.parse(snippet)
    end)
    return ok and tostring(parsed)
        or M.snippet_replace(snippet, function(placeholder)
            return M.snippet_preview(placeholder.text)
        end):gsub("%$0", "")
end

function M.snippet_fix(snippet)
    local texts = {}
    return M.snippet_replace(snippet, function(placeholder)
        texts[placeholder.n] = texts[placeholder.n] or M.snippet_preview(placeholder.text)
        return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
    end)
end

function M.expand(snippet)
    local session = vim.snippet.active() and vim.snippet._session or nil

    local ok, err = pcall(vim.snippet.expand, snippet)
    if not ok then
        local fixed = M.snippet_fix(snippet)
        ok = pcall(vim.snippet.expand, fixed)

        local msg = ok and "Failed to parse snippet,\nbut was able to fix it automatically."
            or ("Failed to parse snippet.\n" .. err)

        GionVim[ok and "warn" or "error"](
            ([[%s
```%s
%s
```]]):format(msg, vim.bo.filetype, snippet),
            { title = "vim.snippet" }
        )
    end

    if session then
        vim.snippet._session = session
    end
end

function M.setup(opts)
    for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
    end
end

return M
