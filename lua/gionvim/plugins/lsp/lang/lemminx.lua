vim.lsp.config("lemminx", {
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("lemminx")
