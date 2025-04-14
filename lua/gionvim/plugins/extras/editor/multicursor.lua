return {
    {
        "jake-stewart/multicursor.nvim",
        lazy = true,
        event = { "CursorMoved", "CursorMovedI" },
        config = function()
            local multicursor = require("multicursor-nvim")
            multicursor.setup()

            local set = vim.keymap.set

            set({ "n", "x" }, "<up>", function()
                multicursor.lineAddCursor(-1)
            end)
            set({ "n", "x" }, "<down>", function()
                multicursor.lineAddCursor(1)
            end)
            set({ "n", "x" }, "<leader><up>", function()
                multicursor.lineSkipCursor(-1)
            end, { desc = "Orient Up Skip Cursor" })
            set({ "n", "x" }, "<leader><down>", function()
                multicursor.lineSkipCursor(1)
            end, { desc = "Orient Down Skip Cursor" })

            set({ "n", "x" }, "<leader>i-", function()
                multicursor.matchAddCursor(1)
            end, { desc = "Match Add Down Cursor" })
            set({ "n", "x" }, "<leader>ij", function()
                multicursor.matchSkipCursor(1)
            end, { desc = "Match Skip Down Cursor" })
            set({ "n", "x" }, "<leader>i+", function()
                multicursor.matchAddCursor(-1)
            end, { desc = "Match Add Up Curslor" })
            set({ "n", "x" }, "<leader>ik", function()
                multicursor.matchSkipCursor(-1)
            end, { desc = "Match Skip Up Cursor" })

            set("n", "<c-leftmouse>", multicursor.handleMouse)
            set("n", "<c-leftdrag>", multicursor.handleMouseDrag)
            set("n", "<c-leftrelease>", multicursor.handleMouseRelease)

            set({ "n", "x" }, "<c-q>", multicursor.toggleCursor)

            multicursor.addKeymapLayer(function(layerSet)
                layerSet({ "n", "x" }, "<left>", multicursor.prevCursor)
                layerSet({ "n", "x" }, "<right>", multicursor.nextCursor)

                layerSet({ "n", "x" }, "<leader>ix", multicursor.deleteCursor)

                layerSet("n", "<esc>", function()
                    if not multicursor.cursorsEnabled() then
                        multicursor.enableCursors()
                    else
                        multicursor.clearCursors()
                    end
                end)
            end)

            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { reverse = true })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorMatchPreview", { link = "Search" })
            hl(0, "MultiCursorDisabledCursor", { reverse = true })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end,
    },
}
