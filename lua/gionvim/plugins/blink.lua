return {
    {
        "saghen/blink.cmp",
        version = "*",
        opts_extend = {
            "sources.completion.enabled_providers",
            "sources.compat",
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "saghen/blink.compat",
                optional = true,
                opts = {},
                version = "*",
            },
        },
        event = "InsertEnter",
        opts = {
            appearance = {
                use_nvim_cmp_as_default = false,
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = true,
                },
            },

            sources = {
                compat = {},
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer" },
                },
            },

            keymap = {
                preset = "enter",
            },
        },
        config = function(_, opts)
            local enabled = opts.sources.completion.enabled_providers
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

            for _, provider in pairs(opts.sources.providers or {}) do
                if provider.kind then
                    require("blink.cmp.types").CompletionItemKind[provider.kind] = provider.kind
                    local transform_items = provider.transform_items
                    provider.transform_items = function(ctx, items)
                        items = transform_items and transform_items(ctx, items) or items
                        for _, item in ipairs(items) do
                            item.kind = provider.kind or item.kind
                        end
                        return items
                    end
                end
            end

            require("blink.cmp").setup(opts)
        end,
    },
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            opts.appearance = opts.appearance or {}
            opts.appearance.kind_icons = GionConfig.icons.kinds
        end,
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                completion = {
                    enabled_providers = { "lazydev" },
                },
                providers = {
                    lsp = {
                        fallback_for = { "lazydev" },
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                    },
                },
            },
        },
    },
}
