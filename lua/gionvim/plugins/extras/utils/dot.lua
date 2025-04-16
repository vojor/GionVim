local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

local function have(path)
    return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            local function add(lang)
                if type(opts.ensure_installed) == "table" then
                    table.insert(opts.ensure_installed, lang)
                end
            end

            vim.filetype.add({
                extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
                filename = {
                    ["vifmrc"] = "vim",
                    [".autocorrectrc"] = "yaml",
                    [".gersemirc"] = "yaml",
                },
                pattern = {
                    ["%.env%.[%w_.-]+"] = "sh",
                },
            })

            add("git_config")

            if have("fish") then
                add("fish")
            end

            if have("rofi") or have("wofi") then
                add("rasi")
            end
        end,
    },
}
