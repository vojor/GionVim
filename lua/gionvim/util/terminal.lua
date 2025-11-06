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
            "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"

        vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

        vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

        vim.o.shellquote = ""
        vim.o.shellxquote = ""
    end
end

return M
