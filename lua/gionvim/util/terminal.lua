local M = {}

function M.setup(shell)
    vim.o.shell = shell or vim.o.shell

    if shell == "pwsh" or shell == "powershell" then
        if vim.fn.executable("pwsh") == 1 then
            vim.o.shell = "pwsh"
        elseif vim.fn.executable("powershell") == 1 then
            vim.o.shell = "powershell"
        else
            return GionVim.error("No powershell executable found")
        end

        vim.o.shellcmdflag =
            "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"

        vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

        vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'

        vim.o.shellquote = ""
        vim.o.shellxquote = ""
    end
end

return M
