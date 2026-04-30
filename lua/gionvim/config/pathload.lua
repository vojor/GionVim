local M = {}

local loaded = {}

local function notify(msg, level, opts)
    if Snacks then
        Snacks.notify(msg, vim.tbl_extend("force", { level = level }, opts or {}))
    else
        local log_level = vim.log.levels[level:upper()] or vim.log.levels.INFO
        vim.notify(msg, log_level, opts)
    end
end

local function safe_require(mod)
    if package.loaded[mod] then
        return true
    end

    return xpcall(function()
        return require(mod)
    end, function(err)
        return debug.traceback(err)
    end)
end

local function create_profiler(opts)
    local stats = {}
    local batch_msgs = {}
    local total_time, total, failed = 0, 0, 0
    local mode = opts.profile and opts.profile.mode or "prod"

    return {
        record = function(mod, time, ok)
            total = total + 1
            total_time = total_time + time
            if not ok then
                failed = failed + 1
            end
            table.insert(stats, { mod, time, ok })
            if mode == "dev" then
                table.insert(batch_msgs, string.format("%s %s (%.2fms)", ok and "✅" or "❌", mod, time))
            end
        end,

        report = function()
            if not opts.profile or total == 0 then
                return
            end
            table.sort(stats, function(a, b)
                return a[2] > b[2]
            end)

            vim.schedule(function()
                local final_report = {}
                table.insert(final_report, "# 📊 Summary")
                table.insert(final_report, string.format("- **Total Modules** : `%d`", total))
                table.insert(final_report, string.format("- **Failed** : `%d`", failed))
                table.insert(final_report, string.format("- **Total Time** : `%.2fms`", total_time))

                if mode == "dev" then
                    table.insert(final_report, "\n---")
                    table.insert(final_report, "## 🐢 Top Slow Modules")

                    local top_n = math.min(opts.profile.top or 5, #stats)
                    for i = 1, top_n do
                        local item = stats[i]
                        table.insert(final_report, string.format("%d. %s (`%.2fms`)", i, item[1], item[2]))
                    end

                    if #batch_msgs > 0 then
                        table.insert(final_report, "\n---")
                        table.insert(final_report, "## 🚀 Load Report")
                        local max_details = 15
                        for i = 1, math.min(#batch_msgs, max_details) do
                            table.insert(final_report, "- " .. batch_msgs[i])
                        end
                        if #batch_msgs > max_details then
                            table.insert(
                                final_report,
                                string.format("\n*... and %d more items*", #batch_msgs - max_details)
                            )
                        end
                    end
                end

                notify(table.concat(final_report, "\n"), failed > 0 and "error" or "info", {
                    title = "LazyLoad Insights",
                    timeout = mode == "dev" and 5000 or 3000,
                })
            end)
        end,
    }
end

local function create_loader(mod_root, opts, profiler)
    return function(mod_name)
        if loaded[mod_name] then
            return true
        end

        if opts.callbacks and opts.callbacks.before_load then
            opts.callbacks.before_load(mod_name)
        end
        local start = vim.uv.hrtime()
        local ok, err = safe_require(mod_name)
        local elapsed = (vim.uv.hrtime() - start) / 1e6

        profiler.record(mod_name, elapsed, ok)
        loaded[mod_name] = true

        if ok then
            if opts.callbacks and opts.callbacks.on_load then
                opts.callbacks.on_load(mod_name, elapsed)
            end
        else
            local err_msg = "LazyLoad Error: " .. mod_name .. "\n" .. (err or "")
            if opts.callbacks and opts.callbacks.on_error then
                opts.callbacks.on_error(mod_name, err, elapsed)
            else
                notify(err_msg, "error", { title = "LazyLoad" })
            end
        end

        if opts.callbacks and opts.callbacks.after_load then
            opts.callbacks.after_load(mod_name, ok)
        end

        if opts.verbose then
            notify(string.format("%s %s (%.2fms)", ok and "✔" or "✘", mod_name, elapsed), "info")
        end

        return ok
    end
end

function M.build_mappings(groups)
    return vim.iter(groups):fold({}, function(acc, target, fts)
        for _, ft in ipairs(fts) do
            acc[ft] = target
        end
        return acc
    end)
end

function M.setup(mod_root, opts)
    opts = opts or {}

    local profiler = create_profiler(opts)
    local load = create_loader(mod_root, opts, profiler)

    local function try_load(sub_mod)
        local full_mod = mod_root:gsub("%.$", "") .. "." .. sub_mod
        if not package.loaded[full_mod] then
            return load(full_mod)
        end
        return true
    end

    if opts.mappings then
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("GionLazyLoad", { clear = true }),
            callback = function(args)
                local target = opts.mappings[args.match]
                if not target then
                    return
                end
                if type(target) == "table" then
                    for _, mod in ipairs(target) do
                        try_load(mod)
                    end
                else
                    try_load(target)
                end
            end,
        })
    end

    for _, rule in ipairs(opts.rules or {}) do
        if rule.event then
            vim.api.nvim_create_autocmd(rule.event, {
                pattern = rule.pattern,
                once = rule.once ~= false,
                callback = function()
                    try_load(rule.module)
                end,
            })
        end
        if rule.keys then
            for _, key in ipairs(rule.keys) do
                vim.keymap.set("n", key, function()
                    if try_load(rule.module) and rule.post_action then
                        rule.post_action()
                    end
                end, { desc = "LazyLoad: " .. rule.module, silent = true })
            end
        end
    end

    if opts.profile then
        vim.defer_fn(function()
            profiler.report()
        end, opts.profile.delay or 3000)
    end
end

return M
