local utils = require('utils_')

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
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.json_tool,
      null_ls.builtins.formatting.lua_format,
      null_ls.builtins.code_actions.gitrebase,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
    }
  }
end)

utils.prepare_module('lspsaga', function(lspsaga)
  lspsaga.setup {
    use_saga_diagnostic_sign = false,
    code_action_prompt = {enable = false},
    border_style = 'round',
    finder_action_keys = {
      open = "o",
      vsplit = "v",
      split = "s",
      quit = {"<Esc>", "q"},
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
      },
    code_action_keys = {
      quit = {"<Esc>", "q"},
    exec = "<CR>",
    },
    rename_action_keys = {
      quit = "<Esc>",
    exec = "<CR>",
    },
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
    pylsp = {
      settings = {
        pyls = {
          configurationSources = {"flake8"},
          plugins = {
            jedi_completion = {enabled = false},
            jedi_hover = {enabled = false},
            jedi_references = {enabled = false},
            jedi_signature_help = {enabled = false},
            jedi_symbols = {enabled = false},
            flake8 = {enabled = true},
            pylsp_mypy = {enabled = true},
            pylint = {enabled = true},
            pydocstyle = {enabled = true},
            rope_completion = {enabled = false}
          }
        }
      },
    },
    pyright = {
      settings = {
        python = {
          analysis = {
            -- logLevel = 'Trace',
            --useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
            -- diagnosticSeverityOverrides = 'none',
          },
        }
      }
    },
    salt_ls = {},
    sumneko_lua = {
      init_options = {
        embeddedLanguages = {
          vim = true,
        }
      },
      settings = {
        Lua = {
          diagnostics = {
            globals = {"vim", "require"},
          },
          color = {
            mode = "SemanticEnhanced"
          },
          telemetry = {
            enable = false
          },
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

  for lsp, _ in pairs(servers) do
    local server_available, requested_server = require('nvim-lsp-installer.servers').get_server(lsp)
    if server_available then
      if not requested_server:is_installed() then
        requested_server:install()
      end
    end
  end

  local function load_lsp_settings(name)
    local status, settings = pcall(require, 'nvim_lsp')
    if status and settings[name] ~= nil then
      return settings[name]
    else
      return {}
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

    if servers[server.name] ~= nil then
      opts = vim.tbl_deep_extend('force', opts, servers[server.name])
    end
    opts = vim.tbl_deep_extend('force', opts, load_lsp_settings(server.name))
    server:setup(opts)
  end)
end)

utils.prepare_module('fidget', function(fidget)
  fidget.setup({})
end)
