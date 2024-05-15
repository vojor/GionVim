return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = { ":TSUpdate" },
        lazy = vim.fn.argc(-1) == 0,
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdate", "TSUpdateSync", "TSUninstall" },
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            -- 为 lua,vim,bash,fish 文件内部函数添加 end
            { "RRethy/nvim-treesitter-endwise" },
        },
        keys = {
            { "<C-space>", desc = "Increment Selection" },
            { "<bs>", mode = "x", desc = "Decrement Selection" },
        },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "diff",
                "git_config",
                "gitcommit",
                "gitignore",
                "python",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "norg",
                "query",
                "regex",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                -- filesize >= 2M, disable treesitter
                disable = function(lang, buf)
                    local max_filesize = 2000 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = false,
                    scope_incremental = "<BS>",
                },
            },
            indent = { enable = true },
            endwise = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ak"] = { query = "@block.outer", desc = "around block" },
                        ["ik"] = { query = "@block.inner", desc = "inside block" },
                        ["ac"] = { query = "@class.outer", desc = "around class" },
                        ["ic"] = { query = "@class.inner", desc = "inside class" },
                        ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
                        ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
                        ["af"] = { query = "@function.outer", desc = "around function " },
                        ["if"] = { query = "@function.inner", desc = "inside function " },
                        ["al"] = { query = "@loop.outer", desc = "around loop" },
                        ["il"] = { query = "@loop.inner", desc = "inside loop" },
                        ["aa"] = { query = "@parameter.outer", desc = "around argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<M-v>",
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>ab"] = { query = "@block.outer", desc = "Swap next block" },
                        ["<leader>af"] = { query = "@function.outer", desc = "Swap next function" },
                        ["<leader>ap"] = { query = "@parameter.inner", desc = "Swap next argument" },
                    },
                    swap_previous = {
                        ["<leader>aB"] = { query = "@block.outer", desc = "Swap previous block" },
                        ["<leader>aF"] = { query = "@function.outer", desc = "Swap previous function" },
                        ["<leader>aP"] = { query = "@parameter.inner", desc = "Swap previous argument" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]k"] = { query = "@block.outer", desc = "Next block start" },
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]o"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]K"] = { query = "@block.outer", desc = "Next block end" },
                        ["]F"] = { query = "@function.outer", desc = "Next function end" },
                        ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                    },
                    goto_previous_start = {
                        ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                        ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
                        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                    },
                    goto_previous_end = {
                        ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                        ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
                        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                    },
                },
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
            vim.schedule(function()
                require("lazy").load({ plugins = { "nvim-treesitter-textobjects" } })
            end)

            -- enable treesitter fold
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end,
    },
}
