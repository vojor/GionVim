local map = GionVim.safe_keymap_set

-- Goto
map("n", "grD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "grd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "grr", vim.lsp.buf.references, { desc = "References" })
map("n", "gry", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Goto Implementation" })

-- Code Action
map("n", "gra", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "grA", GionVim.lsp.action.source, { desc = "Source Action" })

-- Code Lens
map("n", "<leader>le", vim.lsp.codelens.run, { desc = "Run Codelens" })
map("n", "<leader>lE", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })

-- Hover & help
map("n", "<leader>lh", function()
    return vim.lsp.buf.hover()
end, { desc = "Hover" })
map("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
end, { desc = "Signature Help" })

-- Rename
map("n", "grn", vim.lsp.buf.rename, { desc = "Rename Word" })
map("n", "grN", function()
    Snacks.rename.rename_file()
end, { desc = "Rename File" })

-- Status
map("n", "<leader>lp", function()
    Snacks.picker.lsp_config()
end, { desc = "Server Status Information" })

-- calls
map("n", "<leader>li", function()
    vim.lsp.buf.incoming_calls()
end, { desc = "Incoming" })
map("n", "<leader>lo", function()
    vim.lsp.buf.outgoing_calls()
end, { desc = "Outgoing" })

-- Work space
map("n", "<leader>la", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
map("n", "<leader>lm", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })

-- Format
map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "LSP Async Format" })
