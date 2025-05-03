local M = {}

local comment_query_cache = {}

local function get_comment_query(ft)
    if comment_query_cache[ft] then
        return comment_query_cache[ft]
    end
    local ok, query = pcall(vim.treesitter.query.parse, ft, [[((comment) @comment)]])
    if ok then
        comment_query_cache[ft] = query
        return query
    end
end

function M.inside_comment_block()
    if vim.api.nvim_get_mode().mode ~= "i" then
        return false
    end

    if not vim.treesitter.language.get_lang(vim.bo.filetype) then
        return false
    end

    local parser = vim.treesitter.get_parser(nil, nil, { error = false })
    if not parser then
        return false
    end

    local tree = parser:parse()[1]
    if not tree then
        return false
    end

    local query = get_comment_query(vim.bo.filetype)
    if not query then
        return false
    end

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1

    local root = tree:root()

    for _, node, _ in query:iter_captures(root, 0, row, row + 1) do
        local sr, sc, er, ec = node:range()
        if (row > sr or (row == sr and col >= sc)) and (row < er or (row == er and col <= ec)) then
            return true
        end
    end

    return false
end

return M
