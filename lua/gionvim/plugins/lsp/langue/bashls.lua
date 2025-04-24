vim.lsp.config("bashls", {
    filetypes = { "bash", "sh" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("bashls")
