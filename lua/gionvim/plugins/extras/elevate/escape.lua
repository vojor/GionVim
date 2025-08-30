return {
    {
        "nvim-mini/mini.keymap",
        version = false,
        lazy = true,
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local mode = { "i", "c", "x", "s" }
            local map_combo = require("mini.keymap").map_combo

            map_combo(mode, "jk", "<BS><BS><Esc>")
            map_combo(mode, "jj", "<BS><BS><Esc>")
            map_combo(mode, "kj", "<BS><BS><Esc>")

            map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
            map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
        end,
    },
}
