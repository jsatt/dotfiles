local theme = require('theme_')
local utils = require('utils_')

local lsp_configs = {
  bashls = { mason_name = 'bash-language-server' },
  cssls = { mason_name = 'css-lsp' },
  dockerls = { mason_name = 'dockerfile-language-server' },
  emmet_ls = { mason_name = 'emmet-ls' },
  graphql = { mason_name = 'graphql-language-service-cli' },
  html = { mason_name = 'html-lsp' },
  jsonls = { mason_name = 'json-lsp' },
  -- marksman = {mason_name = 'marksman'},
  pylsp = {
    mason_name = 'python-lsp-server',
    on_attach = function(client, bufnr)
      client.server_capabilities.rename = false
    end,
    settings = {
      pylsp = {
        configurationSources = { "flake8" },
        plugins = {
          jedi_completion = { enabled = false },
          jedi_definition = { enabled = false },
          jedi_hover = { enabled = false },
          jedi_references = { enabled = false },
          jedi_signature_help = { enabled = false },
          jedi_symbols = { enabled = false },
          flake8 = { enabled = true },
          pylsp_mypy = { enabled = true },
          pylint = { enabled = true },
          pydocstyle = { enabled = false },
          pyflakes = { enabled = false },
          rope_completion = { enabled = false }
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
  salt_ls = { mason_name = 'salt-lsp' },
  lua_ls = {
    mason_name = 'lua-language-server',
    init_options = {
      embeddedLanguages = {
        vim = true,
      }
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "require" },
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
  tsserver = { -- typescript
    mason_name = 'typescript-language-server',
  },
  vimls = { mason_name = 'vim-language-server', suggest = { fromRuntimepath = true, fromVimruntime = true }, },
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

local dap_configs = {
  'bash-debug-adapter',
}
local linter_configs = {
  'cspell',
}
local formatter_configs = {
  'prettierd',
  'remark-cli',
  'yamlfmt',
}

return {
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
      local srv_opts = lsp_configs[server]
      local lsp_opts = {
        flags = {
          debounce_text_changes = 150,
        },
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = theme.opts.border_style }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = theme.opts
              .border_style }),
        },
      }
      utils.prepare_module('telescope.builtin', function(ts_builtin) -- use telescope for reference lookup
        lsp_opts.handlers["textDocument/references"] = ts_builtin.lsp_references
      end)

      if srv_opts ~= nil then
        lsp_opts = vim.tbl_deep_extend('force', lsp_opts, srv_opts)
      end

      lsp_opts.on_attach = function(client, bufnr)
        if srv_opts and utils.key_in_table('on_attach', srv_opts) then
          srv_opts.on_attach(client, bufnr)
        end
      end

      lspconfig[server].setup(lsp_opts)
    end
  end,
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true


        local lspconfig = require('lspconfig')
        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
          capabilities = capabilities,
        })

        local lsp_win = require('lspconfig.ui.windows')
        local _default_opts = lsp_win.default_opts
        lsp_win.default_opts = function(options)
          local opts = _default_opts(options)
          opts.border = require('theme_').opts.border_style
          return opts
        end
      end,
    },
    {
      'jose-elias-alvarez/null-ls.nvim', -- for formatters and linters
      config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
          sources = {
            null_ls.builtins.code_actions.cspell,
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.cspell.with({ extra_filetypes = { 'text', 'markdown', 'gitcommit' } }),
            null_ls.builtins.diagnostics.zsh,

            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.json_tool,
            null_ls.builtins.formatting.lua_format,
            null_ls.builtins.formatting.remark,
            null_ls.builtins.formatting.yamlfmt,
          }
        })
      end,
    },
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
      opts = {
        ui = {
          border = theme.opts.border_style,
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
      },
      config = function(_, opts)
        require('mason').setup(opts)
        require('mason-lspconfig').setup()
      end,
      dependencies = {
        { 'williamboman/mason-lspconfig.nvim' },
        {
          'WhoIsSethDaniel/mason-tool-installer.nvim',
          opts = {
            ensure_installed = utils.merge_tables({
              utils.flatten_table(lsp_configs, 'mason_name'),
              dap_configs,
              linter_configs,
              formatter_configs,
            })
          },
        },
      }
    }
  },
}
