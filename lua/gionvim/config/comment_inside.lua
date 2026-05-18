local M = {}

local ts_query_cache = {}

local function get_comment_query(ft)
    if ts_query_cache[ft] then
        return ts_query_cache[ft]
    end
    local ok, parsed_query = pcall(function()
        return vim.treesitter.query.get(ft, "comments") or vim.treesitter.query.parse(ft, "((comment) @comment)")
    end)
    if ok and parsed_query then
        ts_query_cache[ft] = parsed_query
        return parsed_query
    end
end

function M.is_inside()
    if vim.api.nvim_get_mode().mode ~= "i" then
        return false
    end

    if not vim.treesitter.language.get_lang(vim.bo.filetype) then
        return false
    end

    local ok_parser, ts_parser = pcall(vim.treesitter.get_parser, 0)
    if not ok_parser or not ts_parser then
        return false
    end

    local ok_tree, raw_tree_output = pcall(function()
        return ts_parser:parse()
    end)
    if not ok_tree or not raw_tree_output then
        return false
    end
    local current_tree = type(raw_tree_output) == "table" and raw_tree_output[1] or raw_tree_output
    if not current_tree then
        return false
    end

    local target_query = get_comment_query(vim.bo.filetype)
    if not target_query then
        return false
    end

    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    cursor_row = cursor_row - 1

    local tree_root = current_tree:root()

    for _, ts_node, _ in target_query:iter_captures(tree_root, 0, cursor_row, cursor_row + 1) do
        local start_row, start_col, end_row, end_col = ts_node:range()
        if
            (cursor_row > start_row or (cursor_row == start_row and cursor_col >= start_col))
            and (cursor_row < end_row or (cursor_row == end_row and cursor_col <= end_col))
        then
            return true
        end
    end

    return false
end

return M
