local utils = require('utils_')

local server_configs = {
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

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

utils.prepare_module('nvim-lsp-installer', function(lsp_installer)
  lsp_installer.setup {
    ensure_installed = utils.get_keys(server_configs),
    automatic_installation = true,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  }

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

    local opts = {
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

    for _, server in ipairs(require('nvim-lsp-installer.servers').get_installed_servers()) do
      if server_configs[server.name] ~= nil then
        opts = vim.tbl_deep_extend('force', opts, server_configs[server.name])
      end
      lspconfig[server.name].setup(opts)
    end
  end)

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


-- require('lspsaga').init_lsp_saga()
utils.prepare_module('lspsaga', function(lspsaga)
  lspsaga.init_lsp_saga {
    border_style = 'rounded',
    finder_action_keys = {
      open = "o",
      vsplit = "v",
      tabe = 't',
      split = "s",
      quit = "<Esc>", -- "q"},
      scroll_down = "<C-f>",
      scroll_up = "<C-d>",
    },
    code_action_keys = {
      quit = {"<Esc>", "q"},
      exec = "<CR>",
    },
    -- new config only
    show_diagnostic_source = true,
    diagnostic_source_bracket = {' ', ':'},
    code_action_lightbulb = {enable = false},
    rename_action_quit = "<Esc>",
  }
end)

utils.prepare_module('fidget', function(fidget)
  fidget.setup({})
end)
