vim.lsp.config("autotools_ls", {
    filetypes = { "config", "automake", "make" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("autotools_ls")
