return {
    {
        "cbochs/portal.nvim",
        lazy = true,
        cmd = "Portal",
        keys = {
            {
                "<leader>pb",
                function()
                    require("portal.builtin").jumplist.tunnel_backward()
                end,
                desc = "Jumplist Backward",
            },
            {
                "<leader>pc",
                function()
                    require("portal.builtin").jumplist.tunnel_forward()
                end,
                desc = "Jumplist Forward",
            },
            {
                "<leader>pd",
                function()
                    require("portal.builtin").changelist.tunnel_backward()
                end,
                desc = "Changelist Backward",
            },
            {
                "<leader>pe",
                function()
                    require("portal.builtin").changelist.tunnel_forward()
                end,
                desc = "Changelist Forward",
            },
            {
                "<leader>pf",
                function()
                    require("portal.builtin").quickfix.tunnel_backward()
                end,
                desc = "Quickfix Backward",
            },
            {
                "<leader>pg",
                function()
                    require("portal.builtin").quickfix.tunnel_forward()
                end,
                desc = "Quickfix Forward",
            },
        },
        opts = {
            log_level = "error",
            window_options = {
                border = "rounded",
            },
        },
    },
}
