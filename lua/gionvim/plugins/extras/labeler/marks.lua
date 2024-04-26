return {
    {
        "chentoast/marks.nvim",
        lazy = true,
        keys = {
            { "mx", desc = "Set Mark X" },
            { "m,", desc = "Set the next available alphabetical (lowercase) mark" },
            { "m;", desc = "Toggle the next available mark at the current line" },
            { "dmx", desc = "Delete Mark X" },
            { "dm-", desc = "Delete all marks on the current line" },
            { "dm<space>", desc = "Delete all marks in the current buffer" },
            { "dm=", desc = "Delete the bookmark under the cursor." },
            { "m]", desc = "Move to next mark" },
            { "m[", desc = "Move to Prev mark" },
            {
                "m:",
                desc = "Preview mark. This will prompt you for a specific mark to preview; press <cr> to preview the next mark.",
            },
            {
                "m}",
                desc = "Move to the next bookmark having the same type as the bookmark under the cursor. Works across buffers.",
            },
            {
                "m{",
                desc = "Move to the previous bookmark having the same type as the bookmark under the cursor. Works across buffers.",
            },
        },
        opts = {},
    },
}
