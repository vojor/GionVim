return {
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic,bold",
                        functions = "bold",
                        keywords = "bold",
                        types = "bold",
                    },
                },
            })
            vim.cmd.colorscheme("nightfox")
        end,
    },
}
