return {
    {
        "tiagovla/scope.nvim",
        lazy = true,
        cmd = { "ScopeLoadState", "ScopeSaveState" },
        keys = {
            { "<leader>bL", "<cmd>ScopeList<CR>", desc = "Show Buffer List" },
            { "<leader>bm", ":ScopeMoveBuf", desc = "Move Current Buffer To The Specified Tab" },
        },
        opts = {},
    },
}
