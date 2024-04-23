return {
    -- 片段支持
    {
        "L3MON4D3/luasnip",
        build = "make install_jsregexp",
        lazy = true,
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local types = require("luasnip.util.types")

            -- load snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load({ path = { vim.fn.stdpath("config") .. "snippets" } })

            -- configuration
            require("luasnip").setup({
                update_events = { "TextChanged", "TextChangedI" },
                delete_check_events = "TextChanged",
            })
            require("luasnip").config.setup({
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxOrange" } },
                        },
                    },
                    [types.insertNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxBlue" } },
                        },
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
            { "lukas-reineke/cmp-rg" },
            { "f3fora/cmp-spell" },
            { "SergioRibera/cmp-dotenv" },
        },
        opts = function()
            local defaults = require("cmp.config.default")()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            return {
                auto_brackets = {},
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "async_path" },
                    { name = "buffer" },
                    {
                        name = "rg",
                        keyword_length = 3,
                    },
                    { name = "spell" },
                    { name = "dotenv" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind =
                            string.format("%s %s", require("config.accredit").icons.kinds[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            async_path = "[Path]",
                            buffer = "[Buffer]",
                            cmdline = "[Cmdline]",
                            luasnip = "[LuaSnip]",
                            nvim_lsp = "[LSP]",
                            rg = "[Rg]",
                            spell = "[Spell]",
                            dotenv = "[Dotenv]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
            cmp.setup(opts)

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })

            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
}
