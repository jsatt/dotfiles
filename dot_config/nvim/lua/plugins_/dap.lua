return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'mfussenegger/nvim-dap-python',
      branch = 'multi-session',
      config = function()
        require('dap-python').setup('python')
      end
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup()
      end
    },
    {
      'rcarriga/nvim-dap-ui',
      opts = {
        floating = {
          border = 'rounded',
        }
      },
      config = function()
        local dapui = require('dapui')
        local dap = require('dap')
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
  },
  config = function()
    local dap = require('dap')

    dap.configurations.python = { {
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
      end,
    } }

    local signs = require('theme_').signs.dap
    for _, sign in pairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.hl, text = sign.text, numhl = sign.numhl, linehl = sign.linehl })
    end
  end
}
