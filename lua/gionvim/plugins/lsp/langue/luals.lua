vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            runtime = { version = "LuaJIT" },
            codeLens = { enable = true },
            completion = { callSnippet = "Both", keywordSnippet = "Both" },
            doc = { privateName = { "^_" } },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
        },
    },
    filetypes = { "lua" },

    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})

vim.lsp.enable("lua_ls")
