vim.lsp.config("vimls", {
    filetypes = { "vim" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("vimls")
