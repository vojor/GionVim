vim.lsp.config("marksman", {
    filetypes = { "markdown", "markdown.mdx" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("marksman")
