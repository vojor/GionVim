local M = {}

local module_cache = {}

local function default_log_levels()
    return {
        warn = vim.log.levels.WARN,
        info = vim.log.levels.INFO,
        debug = vim.log.levels.DEBUG,
        error = vim.log.levels.ERROR,
    }
end

local function path_to_module(root, filepath, use_cache)
    if use_cache and module_cache[filepath] then
        return module_cache[filepath]
    end
    local module_path = filepath:sub(#root + 2):gsub("[/\\]", "."):gsub("%.lua$", "")
    if use_cache then
        module_cache[filepath] = module_path
    end
    return module_path
end

local function set_defaults(opts)
    return {
        ignore_dirs = opts.ignore_dirs or {},
        ignore_files = opts.ignore_files or {},
        only_prefix = opts.only_prefix,
        priority_files = opts.priority_files or {},
        priority_dirs = opts.priority_dirs or {},
        log_levels = opts.log_levels or default_log_levels(),
        verbose = opts.verbose or false,
        reload = opts.reload or false,
        use_cache = opts.use_cache ~= false,
        warn_missing_priority = opts.warn_missing_priority ~= false,
        dependencies = opts.dependencies or {},
        callbacks = opts.callbacks,
        notify_fn = opts.notify_fn or vim.notify,
    }
end

local function should_ignore(name, list)
    return list and vim.tbl_contains(list, name)
end

local function matches_pattern(filename, patterns)
    if not patterns then
        return true
    end
    if type(patterns) == "string" then
        return filename:match(patterns) ~= nil
    elseif type(patterns) == "table" then
        for _, pat in ipairs(patterns) do
            if filename:match(pat) then
                return true
            end
        end
    end
    return false
end

local function add_to_loaded(loaded, file)
    if not loaded[file] then
        loaded[file] = true
        return true
    end
    return false
end

local function handle_callbacks(callbacks, modname, success, output)
    if not callbacks or package.loaded[modname] then
        return
    end
    vim.schedule(function()
        local cb = success and callbacks.on_success or callbacks.on_error
        if cb then
            cb(modname, output)
        end
    end)
end

local function check_dependencies(deps, notify_fn, log)
    local missing = {}
    for _, dep in ipairs(deps or {}) do
        if not package.loaded[dep] then
            table.insert(missing, dep)
        end
    end
    if #missing > 0 then
        vim.schedule(function()
            notify_fn("Missing dependency modules: " .. table.concat(missing, ", "), log.error)
        end)
        return false
    end
    return true
end

local function scan_files(dir, opts, loaded)
    local log = opts.log_levels
    local notify = opts.notify_fn

    local ok, entries = pcall(vim.fn.readdir, dir)
    if not ok then
        notify("Failed to read directory: " .. dir, log.error)
        return
    end

    table.sort(entries)

    for _, subdir in ipairs(opts.priority_dirs) do
        local pdir = dir .. "/" .. subdir
        if vim.fn.isdirectory(pdir) == 1 then
            scan_files(pdir, opts, loaded)
        end
    end

    for _, prio in ipairs(opts.priority_files) do
        local full = dir .. "/" .. prio
        if vim.fn.filereadable(full) == 1 then
            add_to_loaded(loaded, full)
        elseif opts.warn_missing_priority then
            notify("Priority file not found: " .. full, log.warn)
        end
    end

    for _, entry in ipairs(entries) do
        local full = dir .. "/" .. entry
        local is_dir = vim.fn.isdirectory(full) == 1

        if is_dir then
            if not should_ignore(entry, opts.ignore_dirs) then
                scan_files(full, opts, loaded)
            end
        elseif entry:match("%.lua$") and not should_ignore(entry, opts.ignore_files) then
            if matches_pattern(entry, opts.only_prefix) then
                add_to_loaded(loaded, full)
            end
        end
    end
end

function M.autoload(mod_root, opts, base_path)
    opts = set_defaults(opts or {})
    local notify = opts.notify_fn
    local log = opts.log_levels

    base_path = base_path or (vim.fn.stdpath("config") .. "/lua/" .. mod_root:gsub("%.", "/"))
    local loaded = {}

    if not check_dependencies(opts.dependencies, notify, log) then
        return
    end

    local scan_start = vim.uv.hrtime()
    scan_files(base_path, opts, loaded)
    local scan_end = vim.uv.hrtime()
    local scan_time = (scan_end - scan_start) / 1e6

    local load_start = vim.uv.hrtime()
    local total_modules = 0
    local failed_modules = 0

    for filepath, _ in pairs(loaded) do
        total_modules = total_modules + 1
        local modname = mod_root .. "." .. path_to_module(base_path, filepath, opts.use_cache)

        if opts.reload then
            package.loaded[modname] = nil
            if opts.use_cache then
                module_cache[filepath] = nil
            end
        elseif package.loaded[modname] then
            goto continue
        end

        local success, result = xpcall(function()
            return require(modname)
        end, debug.traceback)

        if not success then
            failed_modules = failed_modules + 1
        end

        handle_callbacks(opts.callbacks, modname, success, result)

        if opts.verbose then
            notify(
                success and ("✅ Loaded Succeed: " .. modname) or ("❌ Loaded Failed: " .. modname .. "\n" .. result),
                success and log.debug or log.error
            )
        end

        ::continue::
    end

    local load_end = vim.uv.hrtime()
    local load_time = (load_end - load_start) / 1e6
    local total_time = scan_time + load_time

    if opts.verbose then
        notify(
            string.format(
                "📦 Scan: %.2fms | Load: %.2fms | Total: %.2fms — %d total, %d failed.",
                scan_time,
                load_time,
                total_time,
                total_modules,
                failed_modules
            ),
            log.info
        )
    end

    if opts.callbacks and opts.callbacks.on_finish then
        vim.schedule(opts.callbacks.on_finish)
    end
end

return M
