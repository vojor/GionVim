return {
    {
        "saghen/blink.cmp",
        version = "*",
        opts_extend = {
            "sources.completion.enabled_providers",
            "sources.compat",
            "sources.default",
        },
        dependencies = {
            { "rafamadriz/friendly-snippets" },
            { "Kaiser-Yang/blink-cmp-dictionary" },
            { "xzbdmw/colorful-menu.nvim", opts = {} },
            { "saghen/blink.compat", optional = true, opts = {}, version = "*" },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            snippets = {
                expand = function(snippet, _)
                    return GionVim.cmp.expand(snippet)
                end,
            },
            completion = {
                menu = {
                    border = "rounded",
                    winblend = 10,
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    local highlights_info = require("colorful-menu").blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        return highlights_info.label
                                    else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights = {}
                                    local highlights_info = require("colorful-menu").blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        highlights = highlights_info.highlights
                                    end
                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                    end
                                    return highlights
                                end,
                            },
                        },
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = { enabled = true },
            },

            sources = {
                compat = {},
                default = function()
                    local result = { "lsp", "path", "snippets", "buffer" }
                    if
                        vim.tbl_contains({ "markdown", "text", "tex", "norg" }, vim.bo.filetype)
                        or require("gionvim.config.inscomt").inside_comment_block()
                    then
                        table.insert(result, "dictionary")
                    end
                    return result
                end,
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        name = "Dict",
                        min_keyword_length = 3,
                        max_items = 8,
                        opts = {
                            dictionary_directories = { vim.fn.expand(vim.fn.stdpath("config") .. "/dictionary") },
                        },
                    },
                },
            },

            cmdline = {
                keymap = {
                    ["Tab"] = { "show", "accept" },
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                completion = {
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ":"
                        end,
                    },
                },
            },

            keymap = {
                preset = "enter",
                ["<C-y>"] = { "select_and_accept" },
            },
        },
        config = function(_, opts)
            local enabled = opts.sources.default
            for _, source in ipairs(opts.sources.compat or {}) do
                opts.sources.providers[source] = vim.tbl_deep_extend(
                    "force",
                    { name = source, module = "blink.compat.source" },
                    opts.sources.providers[source] or {}
                )
                if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
                    table.insert(enabled, source)
                end
            end

            if not opts.keymap["<Tab>"] then
                if opts.keymap.preset == "super-tab" then
                    opts.keymap["<Tab>"] = {
                        require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
                        GionVim.cmp.map({ "snippet_forward" }),
                        "fallback",
                    }
                else
                    opts.keymap["<Tab>"] = {
                        GionVim.cmp.map({ "snippet_forward" }),
                        "fallback",
                    }
                end
            end

            opts.sources.compat = nil

            for _, provider in pairs(opts.sources.providers or {}) do
                if provider.kind then
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1

                    CompletionItemKind[kind_idx] = provider.kind
                    CompletionItemKind[provider.kind] = kind_idx

                    local transform_items = provider.transform_items
                    provider.transform_items = function(ctx, items)
                        items = transform_items and transform_items(ctx, items) or items
                        for _, item in ipairs(items) do
                            item.kind = kind_idx or item.kind
                            item.kind_icon = GionVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
                        end
                        return items
                    end

                    provider.kind = nil
                end
            end

            require("blink.cmp").setup(opts)
        end,
    },
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            opts.appearance = opts.appearance or {}
            opts.appearance.kind_icons =
                vim.tbl_extend("force", opts.appearance.kind_icons or {}, GionVim.config.icons.kinds)
        end,
    },
}
