# registers.nvim

```lua
bind_keys = {
    normal    = registers.show_window({ mode = "motion" }),
    visual    = registers.show_window({ mode = "motion" }),
    insert    = registers.show_window({ mode = "insert" }),
    registers = registers.apply_register({ delay = 0.1 }),
    ["<CR>"]  = registers.apply_register(),
    ["<Esc>"] = registers.close_window(),
    ["<C-n>"] = registers.move_cursor_down(),
    ["<C-p>"] = registers.move_cursor_up(),
    ["<C-j>"] = registers.move_cursor_down(),
    ["<C-k>"] = registers.move_cursor_up(),
    ["<Del>"] = registers.clear_highlighted_register(),
    ["<BS>"]  = registers.clear_highlighted_register(),
},
```
