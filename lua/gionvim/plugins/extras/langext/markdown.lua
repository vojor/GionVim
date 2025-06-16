return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = true,
        cmd = "RenderMarkdown",
        ft = { "markdown", "rmd", "norg" },
        opts = {
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            completions = { blink = { enabled = true } },
            latex = { enabled = false },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            Snacks.toggle({
                name = "Render Markdown",
                get = function()
                    return require("render-markdown.state").enabled
                end,
                set = function(enabled)
                    local m = require("render-markdown")
                    if enabled then
                        m.enable()
                    else
                        m.disable()
                    end
                end,
            }):map("<leader>um")
        end,
    },
    {
        "bngarren/checkmate.nvim",
        enabled = false,
        lazy = true,
        ft = "markdown",
        keys = {
            { "<leader>T", "", desc = "TODO", ft = "markdown" },
            { "<leader>Tt", "<cmd>CheckmateToggle<CR>", mode = { "n", "v" }, desc = "Toggle TODO", ft = "markdown" },
            { "<leader>Tc", "<cmd>CheckmateCreate<CR>", mode = { "n", "v" }, desc = "Line To TODO", ft = "markdown" },
            { "<leader>Tu", "<cmd>CheckmateCheck<CR>", mode = { "n", "v" }, desc = "Aim TODO", ft = "markdown" },
            { "<leader>Tn", "<cmd>CheckmateUncheck<CR>", mode = { "n", "v" }, desc = "Unpack TODO", ft = "markdown" },
            {
                "<leader>Tr",
                "<cmd>CheckmateRemoveAllMetadata<CR>",
                mode = { "n", "v" },
                desc = "Delete TODO Meta",
                ft = "markdown",
            },
            { "<leader>Ta", "<cmd>CheckmateArchive<CR>", mode = { "n", "v" }, desc = "Low TODO", ft = "markdown" },
            { "<leader>Tl", "<cmd>CheckmateLint<CR>", mode = { "n", "v" }, desc = "Lint TODO", ft = "markdown" },
        },
        opts = {
            log = {
                level = "error",
            },
            keys = {
                ["<leader>Tt"] = "toggle",
                ["<leader>Tc"] = "check",
                ["<leader>Tu"] = "uncheck",
                ["<leader>Tn"] = "create",
                ["<leader>TR"] = "remove_all_metadata",
                ["<leader>Ta"] = "archive",
            },
        },
    },
}
