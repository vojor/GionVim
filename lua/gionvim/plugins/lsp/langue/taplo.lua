vim.lsp.config("taplo", {
    filetypes = { "toml" },
    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("taplo")
