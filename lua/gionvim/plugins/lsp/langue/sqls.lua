vim.lsp.config("sqls", {
    filetypes = { "sql", "mysql" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("sqls")
