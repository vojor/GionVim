vim.lsp.config("kulala-ls", {
    filetypes = { "http", "rest" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("kulala-ls")
