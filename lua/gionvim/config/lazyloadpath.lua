local M = {}

local module_cache = setmetatable({}, { __mode = "kv" })
local loaded_history = {}

local function path_to_module(root, filepath)
    if module_cache[filepath] then
        return module_cache[filepath]
    end

    local rel = vim.fs.relpath(root, filepath)
    if not rel then
        return nil
    end

    local mod = rel:gsub("[/\\]", "."):gsub("%.lua$", "")
    module_cache[filepath] = mod
    return mod
end

local function safe_require(mod)
    if package.loaded[mod] then
        return true
    end

    return xpcall(function()
        require(mod)
    end, debug.traceback)
end

local function scan(dir, files)
    local fd = vim.uv.fs_scandir(dir)
    if not fd then
        return
    end

    local entries = {}
    while true do
        local name, type = vim.uv.fs_scandir_next(fd)
        if not name then
            break
        end
        table.insert(entries, { name = name, type = type })
    end

    table.sort(entries, function(a, b)
        return a.name < b.name
    end)

    for _, entry in ipairs(entries) do
        local full = vim.fs.joinpath(dir, entry.name)
        local t = entry.type or (vim.uv.fs_stat(full) and vim.uv.fs_stat(full).type)

        if t == "directory" then
            scan(full, files)
        elseif t == "file" and entry.name:match("%.lua$") then
            table.insert(files, full)
        end
    end
end

local function create_profiler(opts)
    local stats = {}
    local total_time, total, failed = 0, 0, 0
    local batch_msgs = {}

    return {
        record = function(mod, time, ok)
            total = total + 1
            total_time = total_time + time
            if not ok then
                failed = failed + 1
            end
            table.insert(stats, { mod, time, ok })
            table.insert(batch_msgs, string.format("%s %s (%.2fms)", ok and "✅" or "❌", mod, time))
        end,

        report = function()
            if not opts.profile then
                return
            end
            table.sort(stats, function(a, b)
                return a[2] > b[2]
            end)

            if Snacks then
                Snacks.notify(table.concat(batch_msgs, "\n"), {
                    title = "🚀LazyLoad Report",
                    level = "info",
                    timeout = 3000,
                })
            else
                print(table.concat(batch_msgs, "\n"))
            end

            local lines = {}
            for i = 1, math.min(opts.profile.top or 5, #stats) do
                local item = stats[i]
                table.insert(lines, string.format("%d. %s (%.2fms)", i, item[1], item[2]))
            end

            if Snacks then
                Snacks.notify(table.concat(lines, "\n"), {
                    title = "🐢Top Slow Modules",
                    level = "warn",
                })
            else
                print(table.concat(lines, "\n"))
            end
        end,
    }
end

function M.setup(mod_root, opts)
    opts = opts or {}

    if opts.mappings then
        opts.rules = opts.rules or {}
        local ft_map = {}
        for mod, fts in pairs(opts.mappings) do
            if type(fts) == "string" then
                fts = { fts }
            end
            for _, ft in ipairs(fts) do
                ft_map[ft] = mod
            end
        end
        table.insert(opts.rules, 1, {
            event = "FileType",
            ft_map = ft_map,
        })
    end

    local profiler = create_profiler(opts)
    local base = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", (mod_root:gsub("%.", "/")))

    local files = {}
    scan(base, files)

    local module_map = {}
    for _, filepath in ipairs(files) do
        local mod_part = path_to_module(base, filepath)
        if mod_part then
            local modname = mod_root .. "." .. mod_part
            local filename = vim.fn.fnamemodify(filepath, ":t:r")
            if module_map[filename] and module_map[filename] ~= modname then
                if Snacks then
                    Snacks.notify(
                        string.format(
                            "Module name conflict for **%s**:\n- Old: `%s` \n- New: `%s`",
                            filename,
                            module_map[filename],
                            modname
                        ),
                        {
                            title = "⚠️ LazyLoad Conflict",
                            level = "warn",
                            icon = "󱓞 ",
                        }
                    )
                else
                    vim.notify("LazyLoad Conflict: " .. filename, vim.log.levels.WARN)
                end
            end
            module_map[filename] = modname
        end
    end

    local function perform_load(mod_name)
        if loaded_history[mod_name] then
            return
        end
        loaded_history[mod_name] = true

        local start = vim.uv.hrtime()
        local ok, err = safe_require(mod_name)
        local elapsed = (vim.uv.hrtime() - start) / 1e6

        profiler.record(mod_name, elapsed, ok)

        if opts.callbacks then
            if ok and opts.callbacks.on_load then
                opts.callbacks.on_load(mod_name, elapsed)
            elseif not ok and opts.callbacks.on_error then
                opts.callbacks.on_error(mod_name, err, elapsed)
            end
        end

        if opts.verbose then
            vim.notify(string.format("%s %s (%.2fms)", ok and "✔" or "✘", mod_name, elapsed))
        end
    end

    for _, rule in ipairs(opts.rules or {}) do
        if rule.event == "FileType" and rule.ft_map then
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local target = rule.ft_map[args.match]
                    if target and module_map[target] then
                        perform_load(module_map[target])
                    end
                end,
            })
        elseif rule.keys and type(rule.keys) == "table" then
            for _, key in ipairs(rule.keys) do
                vim.keymap.set("n", key, function()
                    for name, mod_name in pairs(module_map) do
                        if not rule.pattern or name:match(rule.pattern) then
                            perform_load(mod_name)
                        end
                    end
                    if rule.post_action then
                        rule.post_action()
                    end
                end, { desc = "Lazy load by key: " .. (rule.pattern or "all") })
            end
        elseif rule.pattern and rule.event then
            for name, mod_name in pairs(module_map) do
                if name:match(rule.pattern) then
                    vim.api.nvim_create_autocmd(rule.event, {
                        once = true,
                        callback = function()
                            perform_load(mod_name)
                        end,
                    })
                end
            end
        end
    end

    if opts.profile then
        vim.defer_fn(function()
            profiler.report()
        end, opts.profile.delay or 2000)
    end
end

return M
