local theme = require('theme_')
local utils = require('utils_')

local lsp_configs = {
  bashls = {},
  cssls = {},
  dockerls = {},
  docker_compose_language_service = {},
  emmet_ls = {
    filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "htmlangular", "glimmer" }
  },
  graphql = {},
  html = {},
  jsonls = {},
  -- marksman = {},
  pylsp = {
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
  basedpyright = {
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
  kotlin_language_server = {
    settings = {
      kotlin = {
        codegen = {
          enabled = true,
        },
        external_source = {
          useKlsScheme = true,
          autoConvertToKotlin = true,

        },
        inline_hints = {
          typeHints = true,
          parameterHints = true,
          chainedHints = true,
        },
        compiler = {
          jvm = {
            target = "21",
          }
        }
      }
    }
  },
  lua_ls = {
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
  -- salt_ls = {},
  terraformls = {},
  ts_ls = {},
  vimls = { suggest = { fromRuntimepath = true, fromVimruntime = true }, },
  yamlls = {
    on_attach = function(client, bufnr)
      if string.find(vim.api.nvim_buf_get_name(bufnr), 'k8s2?/helm') then
        -- don't use diagnostics on helm files because the lsp can't handle templating
        vim.diagnostic.enable(false, {bufnr = bufnr})
      end
    end,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.1/all.json"] = {"/k8s/**/*.yaml", "/k8s2/**/*.yaml"},
        }
      }
    }
  },
}

local dap_configs = {
  'bash-debug-adapter',
  'kotlin-debug-adapter',
}
local linter_configs = {
}
local formatter_configs = {
  'ktlint',
  'prettierd',
  'remark-cli',
  'yamlfmt',
}

vim.lsp.inlay_hint.enable()

vim.api.nvim_create_user_command(
  'RestartKLS',
  function()
    for _, client in ipairs(vim.lsp.get_clients({name='kotlin_language_server'})) do
      if not client.is_stopped() and client.name == 'kotlin_language_server' then
        client.rpc.terminate()
        vim.cmd.LspStop(client.id)
        vim.wait(1000,
          function()
            return client.is_stopped()
          end
        )
        vim.cmd.LspStart(client.name)
      end
    end
  end,
  {}
)

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
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = theme.opts.border_style }),
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
      'nvimtools/none-ls.nvim', -- for formatters and linters
      dependencies = {
        {"nvim-lua/plenary.nvim"},
      },
      config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
          diagnostics_format = "#{s}: [#{c}] #{m} ",
          sources = {
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,

            null_ls.builtins.completion.spell,

            null_ls.builtins.diagnostics.ktlint,
            null_ls.builtins.diagnostics.zsh,

            null_ls.builtins.formatting.isort,
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
        {'williamboman/mason-lspconfig.nvim'},
        {
          'WhoIsSethDaniel/mason-tool-installer.nvim',
          opts = {
            ensure_installed = vim.tbl_extend(
              'force',
              vim.tbl_keys(lsp_configs),
              dap_configs,
              linter_configs,
              formatter_configs
            ),
          },
        },
      }
    }
  },
}
