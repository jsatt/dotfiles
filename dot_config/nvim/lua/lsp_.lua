local utils = require('utils_')

local lsp_configs = {
  bashls = {mason_name = 'bash-language-server'},
  cssls = {mason_name = 'css-lsp'},
  dockerls = {mason_name = 'dockerfile-language-server'},
  emmet_ls = {mason_name = 'emmet-ls'},
  html = {mason_name = 'html-lsp'},
  jsonls = {mason_name = 'json-lsp'},
  -- marksman = {mason_name = 'marksman'},
  pylsp = {
    mason_name = 'python-lsp-server',
    on_attach = function(client, bufnr)
      client.server_capabilities.rename = false
    end,
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
    mason_name = 'pyright',
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
  salt_ls = {mason_name = 'salt-lsp'},
  sumneko_lua = {
    mason_name = 'lua-language-server',
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
  terraformls = {
    mason_name = 'terraform-ls',
  },
  vimls = {mason_name = 'vim-language-server', suggest = { fromRuntimepath = true, fromVimruntime = true }, },
  yamlls = {
    mason_name = 'yaml-language-server',
    on_attach = function(client, bufnr)
      if string.find(vim.api.nvim_buf_get_name(bufnr), 'k8s/helm') then
        -- don't use diagnostics on helm files because the lsp can't handle templating
        vim.diagnostic.disable(bufnr)
      end
    end,
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.13/all.json"] = "/k8s/**/*.yaml",
            }
        }
    }
  },
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

utils.prepare_module('mason', function(mason)
  mason.setup {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    providers = {
      "mason.providers.client",
      "mason.providers.registry-api"
    },
  }

  utils.prepare_module('mason-lspconfig', function(mason_lspconfig)
    mason_lspconfig.setup {
      ensure_installed = utils.get_keys(lsp_configs),
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

      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        local srv_opts = lsp_configs[server]
        local opts = {
          flags = {
            debounce_text_changes = 150,
          },
          handlers = {
            ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
            ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded' }),
          },
        }
        utils.prepare_module('telescope.builtin', function(ts_builtin) -- use telescope for reference lookup
            opts.handlers["textDocument/references"] = ts_builtin.lsp_references
        end)

        if srv_opts ~= nil then
          opts = vim.tbl_deep_extend('force', opts, srv_opts)
        end

        opts.on_attach = function(client, bufnr)
          if utils.key_in_table('on_attach', srv_opts) then
            srv_opts.on_attach(client, bufnr)
          end
        end

        lspconfig[server].setup(opts)
      end
    end)

  end)
end)

utils.prepare_module('null-ls', function(null_ls)
  null_ls.setup {
    debug = true,
    log_level = 'debug',
    sources = {
      null_ls.builtins.code_actions.cspell,
      null_ls.builtins.code_actions.gitrebase,
      null_ls.builtins.code_actions.gitsigns,

      null_ls.builtins.diagnostics.cspell.with({extra_filetypes = {'text', 'markdown', 'gitcommit'}}),
      null_ls.builtins.diagnostics.zsh,

      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.json_tool,
      null_ls.builtins.formatting.lua_format,
      null_ls.builtins.formatting.remark,
    }
  }
end)

-- utils.prepare_module('fidget', function(fidget)
--   fidget.setup({})
-- end)
