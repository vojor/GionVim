local M = {}

M.virtual = {}

function M.get_signs(buf, lnum)
    local signs = {}

    if vim.fn.has("nvim-0.10") == 0 then
        for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
            local ret = vim.fn.sign_getdefined(sign.name)[1]
            if ret then
                ret.priority = sign.priority
                signs[#signs + 1] = ret
            end
        end
    end

    local extmarks = vim.api.nvim_buf_get_extmarks(
        buf,
        -1,
        { lnum - 1, 0 },
        { lnum - 1, -1 },
        { details = true, type = "sign" }
    )
    for _, extmark in pairs(extmarks) do
        signs[#signs + 1] = {
            name = extmark[4].sign_hl_group or extmark[4].sign_name or "",
            text = extmark[4].sign_text,
            texthl = extmark[4].sign_hl_group,
            priority = extmark[4].priority,
        }
    end

    table.sort(signs, function(a, b)
        return (a.priority or 0) < (b.priority or 0)
    end)

    return signs
end

function M.get_mark(buf, lnum)
    local marks = vim.fn.getmarklist(buf)
    vim.list_extend(marks, vim.fn.getmarklist())
    for _, mark in ipairs(marks) do
        if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
            return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
        end
    end
end

function M.icon(sign, len)
    sign = sign or {}
    len = len or 2
    local text = vim.fn.strcharpart(sign.text or "", 0, len)
    text = text .. string.rep(" ", len - vim.fn.strchars(text))
    return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

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

function M.statuscolumn()
    local win = vim.g.statusline_winid
    local buf = vim.api.nvim_win_get_buf(win)
    local is_file = vim.bo[buf].buftype == ""
    local show_signs = vim.wo[win].signcolumn ~= "no"

    local components = { "", "", "" }

    local show_open_folds = vim.g.gionvim_statuscolumn and vim.g.gionvim_statuscolumn.folds_open
    local use_githl = vim.g.gionvim_statuscolumn and vim.g.gionvim_statuscolumn.folds_githl

    if show_signs then
        local signs = M.get_signs(buf, vim.v.lnum)

        local has_virtual = false
        for _, fn in ipairs(M.virtual) do
            local virtual = fn(buf, vim.v.lnum, vim.v.virtnum, win)
            if virtual then
                has_virtual = true
                vim.list_extend(signs, virtual)
            end
        end

        local left, right, fold, githl
        for _, s in ipairs(signs) do
            if s.name and s.name:lower():find("^octo_clean") then
                s.texthl = "IblScope"
            end
            if s.name and (s.name:find("GitSign") or s.name:find("MiniDiffSign")) then
                right = s
                if use_githl then
                    githl = s["texthl"]
                end
            else
                left = s
            end
        end
        if vim.v.virtnum ~= 0 and not has_virtual then
            left = nil
        end

        vim.api.nvim_win_call(win, function()
            if vim.fn.foldclosed(vim.v.lnum) >= 0 then
                fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = githl or "Folded" }
            elseif
                show_open_folds
                and not GionVim.ui.skip_foldexpr[buf]
                and tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">"
            then
                fold = { text = vim.opt.fillchars:get().foldopen or "", texthl = githl }
            end
        end)
        components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
        components[3] = is_file and M.icon(fold or right) or ""
    end

    local is_num = vim.wo[win].number
    local is_relnum = vim.wo[win].relativenumber
    if (is_num or is_relnum) and vim.v.virtnum == 0 then
        if vim.fn.has("nvim-0.11") == 1 then
            components[2] = "%l"
        else
            if vim.v.relnum == 0 then
                components[2] = is_num and "%l" or "%r"
            else
                components[2] = is_relnum and "%r" or "%l"
            end
        end
        components[2] = "%=" .. components[2] .. " "
    end

    if vim.v.virtnum ~= 0 then
        components[2] = "%= "
    end

    return table.concat(components, "")
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

    if M.skip_foldexpr[buf] then
        return "0"
    end

    if vim.bo[buf].buftype ~= "" then
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

function M.bufremove(buf)
    buf = buf or 0
    buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

    if vim.bo.modified then
        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
        if choice == 0 or choice == 3 then
            return
        end
        if choice == 1 then
            vim.cmd.write()
        end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_win_call(win, function()
            if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                return
            end
            local alt = vim.fn.bufnr("#")
            if alt ~= buf and vim.fn.buflisted(alt) == 1 then
                vim.api.nvim_win_set_buf(win, alt)
                return
            end

            local has_previous = pcall(vim.cmd, "bprevious")
            if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
                return
            end

            local new_buf = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_win_set_buf(win, new_buf)
        end)
    end
    if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.cmd, "bdelete! " .. buf)
    end
end

return M
