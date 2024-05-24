-- C/C++
require("gionvim.debugger.lang.dap-cpp")
-- Bash
require("gionvim.debugger.lang.dap-bash")

-- Extra debug configuration
require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
