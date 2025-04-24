vim.lsp.config("yamlls", {
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
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },

    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
        textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
    }),
})

vim.lsp.enable("yamlls")
