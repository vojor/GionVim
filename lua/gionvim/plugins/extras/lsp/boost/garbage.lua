return {
    {
        "Zeioth/garbage-day.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            aggressive_mode = false,
            excluded_lsp_clients = {
                "null-ls",
                "jdtls",
            },
            grace_period = (60 * 15),
            wakeup_delay = 3000,
            notifications = false,
            retries = 3,
            timeout = 1000,
        },
    },
}
