local map = GionVim.safe_keymap_set

-- Goto
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })

-- Code Action
map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>lC", GionVim.lsp.action.source, { desc = "Source Action" })

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
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Word" })
map("n", "<leader>lR", function()
    Snacks.rename.rename_file()
end, { desc = "Rename File" })

-- Status
map("n", "<leader>lp", function()
    Snacks.picker.lsp_config()
end, { desc = "Server Status Information" })

-- calls
map("n", "<leader>li", vim.lsp.buf.incoming_calls, { desc = "Incoming" })
map("n", "<leader>lo", vim.lsp.buf.outgoing_calls, { desc = "Outgoing" })

-- Work space
map("n", "<leader>la", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
map("n", "<leader>lm", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })

-- Format
map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "LSP Async Format" })
