local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    local args_str = type(args) == "table" and table.concat(args, " ") or args

    config = vim.deepcopy(config)
    config.args = function()
        local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str))
        if config.type and config.type == "java" then
            return new_args
        end
        return require("dap.utils").splitstr(new_args)
    end
    return config
end

return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            { "<leader>d", "", desc = "debug", mode = { "n", "v" } },
            { "<leader>dw", "", desc = "widgets debug", mode = { "n", "v" } },
            -- stylua: ignore
            { "<leader>dc", function() require("dap").continue() end, desc = "Start Debug Or Gogo Next Continue" },
            -- stylua: ignore
            { "<leader>dn", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
            -- stylua: ignore
            { "<leader>di", function() require("dap").step_into() end, desc = "Single Step And Into" },
            -- stylua: ignore
            { "<leader>do", function() require("dap").step_over() end, desc = "Single Step And Over" },
            -- stylua: ignore
            { "<leader>ds", function() require("dap").step_out() end, desc = "Step Out of Current Function" },
            -- stylua: ignore
            { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            -- stylua: ignore
            { "<leader>dr", function() require("dap").run_last() end, desc = "Restart Debug" },
            -- stylua: ignore
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Break Point" },
            -- stylua: ignore
            { "<leader>da", function() require("dap").terminate() end, desc = "Dap Terminate" },
            -- stylua: ignore
            { "<leader>dh", function() require("dap").session() end, desc = "Dap Session" },
            -- stylua: ignore
            { "<leader>dt", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },

            { "<leader>de", ":DapSetLogLevel", desc = "Dap Setting Log Level" },
            { "<leader>dk", "<cmd>DapRestartFrame<CR>", desc = "Dap Restart Frame" },
            { "<leader>dj", "<cmd>DapLoadLaunchJSON<CR>", desc = "Direct Load Json File Debug" },
            {
                "<leader>dm",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                desc = "Log Point Message",
            },

            -- Widgets UI
            {
                "<leader>dwh",
                function()
                    require("dap.ui.widgets").hover()
                end,
                mode = { "n", "v" },
                desc = "dap.ui.widgets hover",
            },
            {
                "<Leader>dwp",
                function()
                    require("dap.ui.widgets").preview()
                end,
                mode = { "n", "v" },
                desc = "dap.ui.widgets preview",
            },
            {
                "<Leader>dwc",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
                desc = "dap.ui.widgets float centered frames",
            },
            {
                "<Leader>dws",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes)
                end,
                desc = "dap.ui.widgets float centered scopes",
            },
        },
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                lazy = true,
                cmd = { "DapInstall", "DapUninstall" },
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-nvim-dap").setup({
                        ensure_installed = { "bash" },
                        automatic_installation = false,
                    })
                end,
            },
            { "miroshQa/debugmaster.nvim" },
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
        },
        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
            vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
            vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

            for name, sign in pairs(GionVim.config.icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end
            require("gionvim.config.loadpath").autoload("gionvim.plugins.dap.lang")
        end,
    },
    {
        "miroshQa/debugmaster.nvim",
        lazy = true,
        keys = { { "<leader>df", mode = { "n", "v" }, desc = "Debug Mode" } },
        config = function()
            local dm = require("debugmaster")
            vim.keymap.set({ "n", "v" }, "<leader>df", dm.mode.toggle, { nowait = true })
        end,
    },
}
