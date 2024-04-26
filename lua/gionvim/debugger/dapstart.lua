-- 调用特定语言适配器
-- C/C++
require("gionvim.debugger.lang.dap-cpp")
-- bash
require("gionvim.debugger.lang.dap-bash")

-- 额外的调试配置
require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
