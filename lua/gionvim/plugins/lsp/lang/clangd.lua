vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--function-arg-placeholders",
        "--log=verbose",
        "--enable-config",
        "--all-scopes-completion",
        "--clang-tidy-checks=bugprone-*, cert-*, clang-analyzer-*, concurrency-*, cppcoreguidelines-*, google-*, hicpp-*, misc-*, modernize-*, performance-*, portability-*, readability-*",
    },
    filetypes = { "c", "cpp" },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },

    capabilities = require("blink.cmp").get_lsp_capabilities({
        offsetEncoding = { "utf-16" },
        workspace = { fileOperations = { didRename = true, willRename = true } },
    }),
})
vim.lsp.enable("clangd")
