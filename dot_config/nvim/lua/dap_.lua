local utils = require "utils_"

utils.prepare_module('dap', function(dap)

  dap.configurations.python = {{
    type = 'python',
    request = 'attach',
    name = 'Attach Docker',
    pathMappings = {
      {
        -- localRoot = vim.fn.getcwd(),
        localRoot = '${workspaceFolder}',
        remoteRoot = '/usr/src/app',
      }
    },
    connect = function()
      local host = vim.fn.input('Host [127.0.0.1]: ')
      host = host ~= '' and host or '127.0.0.1'
      local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
      return { host = host, port = port }
    end;
  }}

  local signs = require('theme_').dap_signs
  for _, sign in pairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.hl, text = sign.text, numhl = sign.numhl, linehl = sign.linehl })
  end

  utils.prepare_module('dap-python', function(dappy) dappy.setup('python') end)
  utils.prepare_module('dapui', function(dapui)
    dapui.setup({
      floating = {
        border = 'rounded',
      }
    })
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end)

  utils.prepare_module('nvim-dap-virtual-text', function(dap_virt_text)
    dap_virt_text.setup()
  end)
end)
