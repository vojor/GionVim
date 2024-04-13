return {
    -- 文件浏览和导航
    {
        "echasnovski/mini.files",
        version = false,
        lazy = true,
        keys = {
            {
                "<leader>nm",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open MiniFiles (Current File Dir)",
            },
            {
                "<leader>nM",
                function()
                    require("mini.files").open(vim.uv.cwd(), true)
                end,
                desc = "Open MiniFiles (CWD)",
            },
        },
        opts = {
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 30,
            },
            options = {
                use_as_default_explorer = false,
            },
        },
        config = function(_, opts)
            require("mini.files").setup(opts)

            local show_dotfiles = true
            local filter_show = function(fs_entry)
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                require("mini.files").refresh({ content = { filter = new_filter } })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    GionVim.lsp.on_rename(event.data.from, event.data.to)
                end,
            })
        end,
    },
}
