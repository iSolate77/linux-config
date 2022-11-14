local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
  return
end

dap_install.setup {}

dap_install.config("python", {})
-- add other configs here

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/faris/.local/share/nvim/dapinstall/ccppr_vsc/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  }
}
dap.configurations.rust = dap.configurations.cpp
dap.configurations.c = dap.configurations.cpp


dapui.setup {
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
      },
      size = 0.25,
      position = 'right',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  --[[ sidebar = { ]]
  --[[   elements = { ]]
  --[[     { ]]
  --[[       id = "scopes", ]]
  --[[       size = 0.25, -- Can be float or integer > 1 ]]
  --[[     }, ]]
  --[[     { id = "breakpoints", size = 0.25 }, ]]
  --[[   }, ]]
  --[[   size = 40, ]]
  --[[   position = "right", -- Can be "left", "right", "top", "bottom" ]]
  --[[ }, ]]
  --[[ tray = { ]]
  --[[   elements = {}, ]]
  --[[ }, ]]
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
