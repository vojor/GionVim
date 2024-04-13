return {
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local jdtls_capabilities = vim.tbl_deep_extend("force", {}, capabilities, {
                workspace = {
                    configuration = true,
                },
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                        },
                    },
                },
            })

            local config = {
                capabilities = jdtls_capabilities,
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens",
                    "java.base/java.util=ALL-UNNAMED",
                    "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",
                    "-jar",
                    vim.fn.stdpath("data")
                        .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
                    "-configuration",
                    vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
                    "-data",
                    vim.fn.stdpath("data")
                        .. "/workspace/jdtls-workspace"
                        .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
                },
                root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", ".gradlew" }),
                settings = {
                    java = {
                        signatureHelp = {
                            enable = true,
                        },
                        contentProvider = {
                            preferred = "fernflower",
                        },
                        completion = {
                            favoriteStaticMembers = {
                                "org.junit.Assert.*",
                                "org.junit.Assume.*",
                                "org.junit.jupiter.api.Assertions.*",
                                "org.junit.jupiter.api.Assumptions.*",
                                "org.junit.jupiter.api.DynamicContainer.*",
                                "org.junit.jupiter.api.DynamicTest.*",
                                "org.hamcrest.MatcherAssert.assertThat",
                                "org.hamcrest.Matchers.*",
                                "org.hamcrest.CoreMatchers.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                                "org.mockito.Mockito.*",
                            },
                            filteredTypes = {
                                "com.sun.*",
                                "io.micrometer.shaded.*",
                                "java.awt.*",
                                "jdk.*",
                                "sun.*",
                            },
                        },
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                        codeGeneration = {
                            toString = {
                                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            },
                            hashCodeEquals = {
                                useJava7Objects = true,
                            },
                            useBlocks = true,
                        },
                    },
                },
                init_options = {
                    extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
                },
            }
            require("jdtls").start_or_attach(config)
        end,
    },
}
