return {
    {
        "saghen/blink.cmp",
        version = false,
        opts_extend = { "sources.completion.enabled_providers" },
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        opts = {
            fuzzy = {
                prebuilt_binaries = {
                    download = true,
                    force_version = "v0.5.0",
                },
            },
            highlight = {
                use_nvim_cmp_as_default = false,
            },
            nerd_font_variant = "mono",
            windows = {
                autocomplete = {
                    draw = "reversed",
                    winblend = vim.o.pumblend,
                },
                documentation = {
                    auto_show = true,
                },
                ghost_text = {
                    enabled = true,
                },
            },

            accept = { auto_brackets = { enabled = true } },

            sources = {
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
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

            keymap = {
                preset = "enter",
            },
            kind_icons = GionConfig.icons.kinds,
        },
    },
}
