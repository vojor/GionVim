return {
    {
        "loctvl842/monokai-pro.nvim",
        priority = 1000,
        config = function()
            require("monokai-pro").setup({
                styles = {
                    comment = { italic = true },
                    keyword = { italic = false, bold = true },
                    type = { italic = false },
                    storageclass = { italic = true },
                    structure = { italic = true },
                    parameter = { italic = true },
                    annotation = { italic = true },
                    tag_attribute = { italic = true },
                },
                filter = "octagon",
            })
            vim.cmd("colorscheme monokai-pro")
        end,
    },
}
