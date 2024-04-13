return {
    {
        "LeonHeidelbach/trailblazer.nvim",
        lazy = true,
        keys = {
            { "<M-N>", desc = "In Cursor/Design Window/Buffer/ Create/Toggle Trail Mark" },
            { "<M-B>", desc = "Goto Back Trail Mark And Delete" },
            { "<M-J>", desc = "Goto Prev Trail Mark To Old Mark" },
            { "<M-K>", desc = "Goto Next Trail Mark To New Mark" },
            { "<M-n>", desc = "Toggle Design Buffer All Mark List" },
            { "<M-L>", desc = "Delete All Trail Mark" },
            { "<M-p>", desc = "Paste Registers To Last And Delete" },
            { "<M-P>", desc = "Paste Registers To All" },
            { "<M-S>", desc = "Cycle Set Trail Mark Select Mode" },
            { "<M-.>", desc = "Switch Design Trail Mark Stack" },
            { "<M-,>", desc = "Use Design Sort Mode Switch To Trail Mark Stack" },
            { "<M-s>", desc = "Cycle Set Current Trail Mark Sort Mode Stack" },
        },
        opts = {
            mappings = {
                nv = {
                    motions = {
                        new_trail_mark = "<M-N>",
                        track_back = "<M-B>",
                        peek_move_next_down = "<M-J>",
                        peek_move_previous_up = "<M-K>",
                        move_to_nearest = "<M-n>",
                        toggle_trail_mark_list = "<M-m>",
                    },
                    actions = {
                        delete_all_trail_marks = "<M-L>",
                        paste_at_last_trail_mark = "<M-p>",
                        paste_at_all_trail_marks = "<M-P>",
                        set_trail_mark_select_mode = "<M-S>",
                        switch_to_next_trail_mark_stack = "<M-.>",
                        switch_to_previous_trail_mark_stack = "<M-,>",
                        set_trail_mark_stack_sort_mode = "<M-s>",
                    },
                },
            },
        },
    },
}
