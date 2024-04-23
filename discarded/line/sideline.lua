return {
    -- SideLine
    {
        "sidebar-nvim/sidebar.nvim",
        enabled = false,
        lazy = true,
        cmd = "SidebarNvimToggle",
        keys = {
            { "<leader>sbt", "<cmd>SidebarNvimToggle<CR>", desc = "Toggle SideBar" },
            { "<leader>sbu", "<cmd>SidebarNvimUpdate<CR>", desc = "Update SideBar" },
            { "<leader>sbf", "<cmd>SidebarNvimFocus<CR>", desc = "Focus Sidebar" },
            { "<leader>sbr", ":SidebarNvimResize ", desc = "Resize Sidebar" },
        },
        opts = {},
    },
}

