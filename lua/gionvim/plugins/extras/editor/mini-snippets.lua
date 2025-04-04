if gionvim_docs then
    vim.g.gionvim_mini_snippets_in_completion = true
end

local include_in_completion = vim.g.gionvim_mini_snippets_in_completion == nil
    or vim.g.gionvim_mini_snippets_in_completion

local function expand_from_lsp(snippet)
    local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
    insert({ body = snippet })
end

local function jump(direction)
    local is_active = MiniSnippets.session.get(false) ~= nil
    if is_active then
        MiniSnippets.session.jump(direction)
        return true
    end
end

local expand_select_override = nil

return {
    {
        "echasnovski/mini.snippets",
        event = "InsertEnter",
        dependencies = "rafamadriz/friendly-snippets",
        opts = function()
            GionVim.cmp.actions.snippet_stop = function() end
            GionVim.cmp.actions.snippet_forward = function()
                return jump("next")
            end

            local mini_snippets = require("mini.snippets")
            return {
                snippets = { mini_snippets.gen_loader.from_lang() },

                expand = {
                    select = function(snippets, insert)
                        local select = expand_select_override or MiniSnippets.default_select
                        select(snippets, insert)
                    end,
                },
            }
        end,
    },

    {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            if include_in_completion then
                opts.snippets = { preset = "mini_snippets" }
                return
            end

            local blink = require("blink.cmp")
            expand_select_override = function(snippets, insert)
                blink.cancel()
                vim.schedule(function()
                    MiniSnippets.default_select(snippets, insert)
                end)
            end
            opts.sources.default = vim.tbl_filter(function(source)
                return source ~= "snippets"
            end, opts.sources.default)
            opts.snippets = {
                expand = function(snippet)
                    expand_from_lsp(snippet)
                    blink.resubscribe()
                end,
                active = function()
                    return MiniSnippets.session.get(false) ~= nil
                end,
                jump = function(direction)
                    jump(direction == -1 and "prev" or "next")
                end,
            }
        end,
    },
}
