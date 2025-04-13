return {
    -- Format
    {
        "stevearc/conform.nvim",
        lazy = true,
        cmd = "ConformInfo",
        event = "BufWritePre",
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({ async = true }, function(err)
                        if not err then
                            local mode = vim.api.nvim_get_mode().mode
                            if vim.startswith(string.lower(mode), "v") then
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                                    "n",
                                    true
                                )
                            end
                        end
                    end)
                end,
                mode = { "n", "v" },
                desc = "Format Buffer",
            },
        },
        opts = {
            default_format_opts = {
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "gersemi" },
                json = { "biome" },
                jsonc = { "biome" },
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                lua = { "stylua" },
                markdown = { "injected" },
                norg = { "injected" },
                python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
                sh = { "shfmt", "shellharden" },
                sql = { "sqlfluff" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
                ["*"] = { "autocorrect" },
            },
            format_after_save = function(bufnr)
                if vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 3000 }
            end,
            formatters = {
                injected = {
                    options = { ignore_errors = true },
                },
                shfmt = {
                    prepend_args = { "-i", "4", "-ci" },
                },
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, opts)
            require("conform").setup(opts)
        end,
    },
}
