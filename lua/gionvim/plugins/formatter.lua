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
                    require("conform").format({ async = true, lsp_fallback = true }, function(err)
                        if not err then
                            if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
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
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "cmake_format" },
                json = { "biome", "biome-check" },
                jsonc = { "biome", "biome-check" },
                javascript = { "biome", "biome-check" },
                javascriptreact = { "biome", "biome-check" },
                typescript = { "biome", "biome-check" },
                typescriptreact = { "biome", "biome-check" },
                lua = { "stylua" },
                markdown = { "mdformat", "injected" },
                norg = { "injected" },
                python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
                sh = { "shellharden", "shfmt" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
                ["*"] = { "autocorrect" },
            },
            log_level = vim.log.levels.ERROR,
            format_after_save = function(bufnr)
                if vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 5000, lsp_fallback = true }
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
