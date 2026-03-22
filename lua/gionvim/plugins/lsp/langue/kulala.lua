vim.lsp.config("kulala_ls", {
    filetypes = { "http", "rest" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("kulala-ls")
