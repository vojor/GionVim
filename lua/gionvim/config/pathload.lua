local M = {}

local loaded = {}
local cache = {}

local notify_queue = {}
local notify_timer = nil

local gion_group = vim.api.nvim_create_augroup("GionLazyLoad", { clear = true })

local function flush_notify(opts)
    if #notify_queue == 0 then
        return
    end

    local lines = {}
    local level = "info"

    for _, item in ipairs(notify_queue) do
        table.insert(lines, item.msg)

        if item.level == "error" then
            level = "error"
        elseif item.level == "warn" and level ~= "error" then
            level = "warn"
        end
    end

    notify_queue = {}
    local msg = table.concat(lines, "\n")

    local final_opts = vim.tbl_extend("force", opts or {}, {
        level = level,
    })

    if Snacks then
        Snacks.notify(msg, final_opts)
    else
        local log_level = vim.log.levels[level:upper()] or vim.log.levels.INFO
        vim.notify(msg, log_level, final_opts)
    end
end

local function notify(msg, level, opts)
    opts = opts or {}
    opts.level = level or "info"

    table.insert(notify_queue, { msg = msg, level = opts.level })

    if notify_timer then
        return
    end

    notify_timer = vim.defer_fn(function()
        flush_notify(opts)
        notify_timer = nil
    end, 100)
end

local function safe_require(mod)
    if package.loaded[mod] then
        return true, package.loaded[mod]
    end

    if cache[mod] ~= nil then
        return cache[mod].ok, cache[mod].res
    end

    local ok, result = xpcall(require, debug.traceback, mod)
    cache[mod] = { ok = ok, res = result }
    return ok, result
end

local function create_profiler(opts)
    if not opts.profile then
        return {
            record = function() end,
            report = function() end,
        }
    end

    local stats = {}
    local batch_msgs = {}
    local total_time, total, failed = 0, 0, 0
    local mode = opts.profile.mode or "prod"

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
            if total == 0 then
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

                    table.insert(final_report, "\n---")
                    table.insert(final_report, "## 🐢 Top Slow Modules")

                    local top_n = math.min(opts.profile.top or 5, #stats)
                    for i = 1, top_n do
                        local item = stats[i]
                        table.insert(final_report, string.format("%d. %s (`%.2fms`)", i, item[1], item[2]))
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

local function create_loader(root, opts, profiler)
    root = root:gsub("%.$", "")

    return function(mod_name)
        local full_mod_name = mod_name:find(root, 1, true) == 1 and mod_name or (root .. "." .. mod_name)

        if loaded[full_mod_name] then
            return true
        end
        if opts.callbacks and opts.callbacks.before_load then
            opts.callbacks.before_load(full_mod_name)
        end

        local start = vim.uv.hrtime()
        local ok, err = safe_require(full_mod_name)
        local elapsed = (vim.uv.hrtime() - start) / 1e6

        profiler.record(full_mod_name, elapsed, ok)

        if ok then
            loaded[full_mod_name] = true
        end

        if ok then
            if opts.callbacks and opts.callbacks.on_load then
                opts.callbacks.on_load(full_mod_name, elapsed)
            end
        else
            local err_msg = "LazyLoad Error: " .. full_mod_name .. "\n" .. (err or "")
            if opts.callbacks and opts.callbacks.on_error then
                opts.callbacks.on_error(full_mod_name, err, elapsed)
            else
                notify(err_msg, "error", { title = "LazyLoad" })
            end
        end

        if opts.callbacks and opts.callbacks.after_load then
            opts.callbacks.after_load(full_mod_name, ok)
        end

        if opts.verbose then
            notify(string.format("%s %s (%.2fms)", ok and "✔" or "✘", full_mod_name, elapsed), "info")
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

    if opts.mappings then
        vim.api.nvim_create_autocmd("FileType", {
            group = gion_group,
            callback = function(args)
                local target = opts.mappings[args.match]
                if not target then
                    return
                end
                if type(target) == "table" then
                    for _, mod in ipairs(target) do
                        if load(mod) then
                            break
                        end
                    end
                else
                    load(target)
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
                    load(rule.module)
                end,
            })
        end
        if rule.keys then
            for _, key in ipairs(rule.keys) do
                vim.keymap.set("n", key, function()
                    if load(rule.module) and rule.post_action then
                        rule.post_action()
                    end
                end, { desc = "LazyLoad: " .. rule.module, silent = true })
            end
        end
    end
    if opts.profile then
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                vim.defer_fn(function()
                    profiler.report()
                end, opts.profile.delay or 2000)
            end,
        })
    end
end

return M
