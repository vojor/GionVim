return {
    {
        "mfussenegger/nvim-jdtls",
        enabled = false,
        lazy = true,
        ft = "java",
        config = function()
            local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
            local launcher_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
            local config_path = jdtls_path .. "/config_linux"
            local workspace_dir = vim.fn.stdpath("data")
                .. "/workspace/jdtls-workspace/"
                .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

            vim.fn.mkdir(workspace_dir, "p")

            local config = {

                capabilities = require("blink.cmp").get_lsp_capabilities({
                    workspace = { fileOperations = { didRename = true, willRename = true }, configuration = true },
                }),

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
                    launcher_path,
                    "-configuration",
                    config_path,
                    "-data",
                    workspace_dir,
                },
                root_dir = require("jdtls.setup").find_root({
                    ".git",
                    "mvnw",
                    "gradlew",
                    "pom.xml",
                    "build.gradle",
                }),
                settings = {
                    java = {
                        signatureHelp = { enable = true },
                        contentProvider = { preferred = "fernflower" },
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
                    extendedClientCapabilities = { resolveAdditionalTextEditsSupport = true },
                },
            }
            require("jdtls").start_or_attach(config)
        end,
    },
}
