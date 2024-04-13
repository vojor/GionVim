# neo-tree.nvim

```lua
mappings = {
    ["<space>"] = "none"
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["<esc>"] = "cancel", 
    ["P"] = { "toggle_preview", config = { use_float = true } },
    ["l"] = "focus_preview",
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    ["t"] = "open_tabnew",
    ["w"] = "open_with_window_picker",
    ["C"] = "close_node",
    ["z"] = "close_all_nodes",
    ["a"] = { 
        "add",
        config = {
        show_path = "none"
        }
    },
    ["A"] = "add_directory",
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy",
    ["m"] = "move",
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
    }
}
```
