vim.lsp.config("neocmake", {
    fileypes = { "cmake" },
    init_options = {
        format = { enable = false },
        lint = { enable = true },
        scan_cmake_in_package = true,
    },

    capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = {
            fileOperations = { didRename = true, willRename = true },
            didChangeWatchedFiles = { dynamicRegistration = true },
        },
    }),
})

vim.lsp.enable("neocmake")
