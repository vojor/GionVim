return {
    -- 美化注释
    {
        "LudoPinelli/comment-box.nvim",
        enabled = false,
        lazy = true,
        keys = {
            -- ll,lc,lr/box
            {
                "<leader>sbl",
                "<cmd>lua require('comment-box').llbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Left Align",
            },
            {
                "<leader>sbc",
                "<cmd>lua require('comment-box').lcbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Center Align",
            },
            {
                "<leader>sbr",
                "<cmd>lua require('comment-box').lrbox()<CR>",
                mode = { "n", "v" },
                desc = "Left Align Box Right Align",
            },
            -- cl,cc,cr/box
            {
                "<leader>sbL",
                "<cmd>lua require('comment-box').clbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Left Align",
            },
            {
                "<leader>sbC",
                "<cmd>lua require('comment-box').ccbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Center Align",
            },
            {
                "<leader>sbR",
                "<cmd>lua require('comment-box').crbox()<CR>",
                mode = { "n", "v" },
                desc = "Center Box Right Align",
            },
            -- rl,rc,rr/box
            {
                "<leader>sbi",
                "<cmd>lua require('comment-box').rlbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Left Align",
            },
            {
                "<leader>sbj",
                "<cmd>lua require('comment-box').rcbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Center Align",
            },
            {
                "<leader>sbk",
                "<cmd>lua require('comment-box').rrbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Align Box Right Align",
            },
            -- al,ac,ar/box
            {
                "<leader>sbo",
                "<cmd>lua require('comment-box').albox()<CR>",
                mode = { "n", "v" },
                desc = "Left Aligned Adapted Box",
            },
            {
                "<leader>sbp",
                "<cmd>lua require('comment-box').acbox()<CR>",
                mode = { "n", "v" },
                desc = "Centered adapted box",
            },
            {
                "<leader>sbq",
                "<cmd>lua require('comment-box').arbox()<CR>",
                mode = { "n", "v" },
                desc = "Right Aligned Adapted Box",
            },
        },
        opts = {},
    },
}
