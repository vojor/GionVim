return {
    {
        "chentoast/marks.nvim",
        lazy = true,
        keys = {
            { "<leader>m", "", desc = "mark" },
            { "<leader>mx", desc = "Set Mark(Wait Input)" },
            { "<leader>md", desc = "Delete Mark(Wait Input)" },
            { "<leader>m,", desc = "Set Line Mark" },
            { "<leader>m-", desc = "Delete Line Mark" },
            { "<leader>m<space>", desc = "Delete Buffer Mark" },
            { "<leader>m]", desc = "Goto Next Mark" },
            { "<leader>m[", desc = "Goto Prev Mark" },
            { "<leader>m:", desc = "Preview Mark(Wait Input)" },
            { "<leader>mg", desc = "Toggle Mark" },
            { "<leader>mD", desc = "Delete Bookmark" },
        },
        opts = {
            default_mappings = false,
            mappings = {
                set = "<leader>mx",
                delete = "<leader>md",
                set_next = "<leader>m,",
                delete_line = "<leader>m-",
                delete_buf = "<leader>m<space>",
                next = "<leader>m]",
                prev = "<leader>m[",
                preview = "<leader>m:",
                toggle = "<leader>mg",

                delete_bookmark = "<leader>mD",
            },
        },
        config = function(_, opts)
            require("marks").setup(opts)
        end,
    },
}
