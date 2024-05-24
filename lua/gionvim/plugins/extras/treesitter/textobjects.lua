return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            if GionVim.is_loaded("nvim-treesitter") then
                local opts = GionVim.opts("nvim-treesitter")
                require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
            end

            local move = require("nvim-treesitter.textobjects.move")
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name]
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
    },
}
