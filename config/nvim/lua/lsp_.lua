local utils = require('common_')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

utils.prepare_module('lspconfig', function(lspconfig)
  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = capabilities,
  })
  local lsp_win = require('lspconfig.ui.windows')
  local _default_opts = lsp_win.default_opts
  lsp_win.default_opts = function(options)
      local opts = _default_opts(options)
      opts.border = "rounded"
      return opts
  end
end)

utils.prepare_module('null-ls', function(null_ls)
  null_ls.setup {
    sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
    }
  }
end)

utils.prepare_module('nlspsettings', function(nlspsettings)
  nlspsettings.setup {
    config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
    local_settings_root_markers = { '.git' },
    jsonls_append_default_schemas = true
  }
end)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
utils.prepare_module('nvim-lsp-installer', function(lsp_installer)
  lsp_installer.settings {
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  }

  local servers = {
    cssls = {},
    dockerls = {},
    emmet_ls = {},
    html = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = {
      init_options = {
        embeddedLanguages = {
          vim = true,
        }
      },
      settings = {
        Lua = {
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            }
          }
        }
      } 
    },
    vimls = { suggest = { fromRuntimepath = true, fromVimruntime = true }, },
    yamlls = {},
  }

  for lsp, lsp_opts in pairs(servers) do
    local server_available, requested_server = require('nvim-lsp-installer.servers').get_server(lsp)
    if server_available then
      if not requested_server:is_installed() then
        requested_server:install()
      end
    end
  end

  lsp_installer.on_server_ready(function(server)
    local opts = {
      -- capabilities = capabilities,
      -- settings = {},
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
        require('illuminate').on_attach(client)
        require('aerial').on_attach(client, bufnr)
      end,
    }
    opts = vim.tbl_deep_extend('force', opts, servers[server.name])
    -- if lsp == 'sumneko_lua' then
    --   opts.cmd = {'/Users/jeremy.satterfield/.local/share/nvim/lsp_servers/sumneko_lua/sumneko_lua.tmp/extension/server/bin/lua-language-server'}
    -- elseif lsp == 'pyright' then
    --   opts.cmd = {'/Users/jeremy.satterfield/.local/share/nvim/lsp_servers/python/pyright.tmp/node_modules/.bin/pyright-langserver', '--stdio'}
    -- elseif lsp == 'html' then
    --   opts.cmd = {'/Users/jeremy.satterfield/.local/share/nvim/lsp_servers/html/html.tmp/node_modules/.bin/vscode-html-language-server',  '--stdio'}
    -- elseif lsp == 'vimls' then
    -- opts.cmd = {'/Users/jeremy.satterfield/.local/share/nvim/lsp_servers/vim/vimls.tmp/node_modules/.bin/vim-language-server',  '--stdio'}
    -- elseif lsp == 'dockerls' then
    --   opts.cmd = {'/Users/jeremy.satterfield/.local/share/nvim/lsp_servers/dockerfile/dockerls.tmp/node_modules/.bin/docker-langserver',  '--stdio'}
    -- end
    server:setup(opts)
  end)
end)


vim.diagnostic.config {
  signs = {
    active = require('common_').signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
