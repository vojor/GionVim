return {
    -- LSP basic service
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>ui", "<cmd>LspInfo<CR>", desc = "Show Lspconfig Info" },
            { "<leader>us", "<cmd>LspStart<CR>", desc = "Start LspConfig" },
            { "<leader>ut", "<cmd>LspStop<CR>", desc = "Stop Lspconfig" },
            { "<leader>ur", "<cmd>LspRestart<CR>", desc = "Restart LspConfig" },
        },
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
                cmd = { "LspInstall", "LspUninstall" },
                dependencies = { "mason.nvim" },
                opts = {
                    ensure_installed = { "marksman", "lemminx" },
                    automatic_installation = false,
                },
            },
        },
        opts = function()
            local ret = {
                diagnostics = {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = GionConfig.icons.diagnostics.Error,
                            [vim.diagnostic.severity.WARN] = GionConfig.icons.diagnostics.Warn,
                            [vim.diagnostic.severity.HINT] = GionConfig.icons.diagnostics.Hint,
                            [vim.diagnostic.severity.INFO] = GionConfig.icons.diagnostics.Info,
                        },
                    },
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                    -- virtual_text = false,
                    virtual_text = {
                        spacing = 4,
                        prefix = "●",
                        source = "if_many",
                    },
                    float = {
                        source = "if_many",
                    },
                },
                inlay_hints = {
                    enabled = true,
                    exclude = {},
                },
                codelens = {
                    enabled = false,
                },
                document_highlight = {
                    enabled = false,
                },
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                servers = { "vimls", "bashls", "marksman", "lemminx", "taplo" },
            }
            return ret
        end,
        config = function(_, opts)
            GionVim.lsp.setup()

            -- diagnostics signs
            if vim.fn.has("nvim-0.10.0") == 0 then
                if type(opts.diagnostics.signs) ~= "boolean" then
                    for severity, icon in pairs(opts.diagnostics.signs.text) do
                        local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
                        name = "DiagnosticSign" .. name
                        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                    end
                end
            end

            if vim.fn.has("nvim-0.10") == 1 then
                -- inlay hints
                if opts.inlay_hints.enabled then
                    GionVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
                        if
                            vim.api.nvim_buf_is_valid(buffer)
                            and vim.bo[buffer].buftype == ""
                            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                        then
                            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                        end
                    end)
                end

                -- code lens
                if opts.codelens.enabled and vim.lsp.codelens then
                    GionVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
                        vim.lsp.codelens.refresh()
                        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                            buffer = buffer,
                            callback = vim.lsp.codelens.refresh,
                        })
                    end)
                end
            end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = GionConfig.icons.diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            vim.lsp.set_log_level("error")

            local lspconfig = require("lspconfig")

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local new_capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})

            -- Capabilities are different for different language servers
            local clangd_capabilities = vim.tbl_deep_extend("force", vim.deepcopy(new_capabilities), {
                offsetEncoding = { "utf-16" },
            })
            local json_capabilities = vim.tbl_deep_extend("force", vim.deepcopy(new_capabilities), {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                        },
                    },
                },
            })
            local yaml_capabilities = vim.tbl_deep_extend("force", vim.deepcopy(new_capabilities), {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            })
            local neocmake_capabilities = vim.tbl_deep_extend("force", vim.deepcopy(new_capabilities), {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            })

            local servers = opts.servers

            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--header-insertion-decorators",
                    "--function-arg-placeholders",
                    "--log=verbose",
                    "--enable-config",
                    "--all-scopes-completion",
                    "--clang-tidy-checks=bugprone-*, cert-*, clang-analyzer-*, concurrency-*, cppcoreguidelines-*, google-*, hicpp-*, misc-*, modernize-*, performance-*, portability-*, readability-*",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                capabilities = clangd_capabilities,
            })

            lspconfig.neocmake.setup({
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end,
                single_file_support = true,
                init_options = {
                    format = {
                        enable = false,
                    },
                    scan_cmake_in_package = true,
                },
                capabilities = neocmake_capabilities,
            })

            lspconfig.jsonls.setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
                capabilities = json_capabilities,
            })

            lspconfig.yamlls.setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                        validate = true,
                    },
                },
                capabilities = yaml_capabilities,
            })

            lspconfig.basedpyright.setup({
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            typeCheckingMode = "strict",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
                capabilities = vim.deepcopy(new_capabilities),
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        codeLens = {
                            enable = true,
                        },
                        completion = {
                            callSnippet = "Both",
                            keywordSnippet = "Both",
                        },
                        doc = {
                            privateName = { "^_" },
                        },
                        hint = {
                            enable = true,
                            setType = false,
                            paramType = true,
                            paramName = "Disable",
                            semicolon = "Disable",
                            arrayIndex = "Disable",
                        },
                    },
                },
                capabilities = vim.deepcopy(new_capabilities),
            })

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    capabilities = vim.deepcopy(new_capabilities),
                })
            end

            -- Transfer keybinds
            require("gionvim.plugins.lsp.keymaps")
        end,
    },
}
