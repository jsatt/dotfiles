local theme = require('theme_')
local utils = require('utils_')

local lsp_configs = {
  bashls = {},
  cspell_ls = {
    cmd = {"cspell-lsp", "--stdio"},
    filetypes = { 'text', 'comment', 'markdown', 'gitcommit', },
  },
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
  -- pylsp = {
  --   on_attach = function(client, bufnr)
  --     client.server_capabilities.rename = false
  --   end,
  --   settings = {
  --     pylsp = {
  --       configurationSources = { "flake8" },
  --       plugins = {
  --         jedi_completion = { enabled = false },
  --         jedi_definition = { enabled = false },
  --         jedi_hover = { enabled = false },
  --         jedi_references = { enabled = false },
  --         jedi_signature_help = { enabled = false },
  --         jedi_symbols = { enabled = false },
  --         flake8 = { enabled = true },
  --         pylsp_mypy = { enabled = true },
  --         pylint = { enabled = true, executable = 'pylint' },
  --         pydocstyle = { enabled = false },
  --         pyflakes = { enabled = false },
  --         rope_completion = { enabled = false }
  --       }
  --     }
  --   },
  -- },
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
          typeCheckingMode = 'standard',
          -- diagnosticSeverityOverrides = 'none',
        },
      }
    }
  },
  kotlin_lsp = {},
  -- kotlin_language_server = {
  --   settings = {
  --     kotlin = {
  --       codegen = {
  --         enabled = true,
  --       },
  --       external_source = {
  --         useKlsScheme = true,
  --         autoConvertToKotlin = true,
  --
  --       },
  --       inline_hints = {
  --         typeHints = true,
  --         parameterHints = true,
  --         chainedHints = true,
  --       },
  --       compiler = {
  --         jvm = {
  --           target = "21",
  --         }
  --       }
  --     }
  --   }
  -- },
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
        -- color = {
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
  },
  -- remark_ls = {},
  ruff = {
    init_options = {
      settings = {
        configurationPreference = "filesystemFirst",
        lineLength = 119,
        configuration = {
          lint = {
            select = { "E", "F", "W", "I" },
          },
          format = {
            ['quote-style'] = 'single',
            ['indent-style'] = 'space',
            ['line-ending'] = 'lf',
          },
        },
      },
    },
  },
  -- salt_ls = {},
  terraformls = {},
  ts_ls = {},
  vimls = { suggest = { fromRuntimepath = true, fromVimruntime = true }, },
  yamlls = {
    on_attach = function(client, bufnr)
      if string.find(vim.api.nvim_buf_get_name(bufnr), 'k8s2?/helm') then
        -- don't use diagnostics on helm files because the lsp can't handle templating
        vim.diagnostic.enable(false, { bufnr = bufnr })
      end
    end,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.1/all.json"] = { "/k8s/**/*.yaml", "/k8s2/**/*.yaml" },
        }
      }
    }
  },
}

local mason_install = {
  -- dap
  'bash-debug-adapter',
  'kotlin-debug-adapter',
  -- formatter
  'ktlint',
  'prettierd',
  'remark-cli',
  'yamlfmt',
  -- other
  'tree-sitter-cli',
}

vim.lsp.inlay_hint.enable()
vim.lsp.config('*', {
  flags = {
    debounce_text_changes = 150,
  },
})
utils.prepare_module('telescope.builtin', function(ts_builtin) -- use telescope for reference lookup
  local orig_references = vim.lsp.buf.references
  vim.lsp.buf.references = function(context, opts)
    orig_references(context, vim.tbl_deep_extend('keep', opts or {}, { on_list = ts_builtin.lsp_references }))
  end
  local orig_doc_symbols = vim.lsp.buf.document_symbol
  vim.lsp.buf.document_symbol = function(opts)
    orig_doc_symbols(vim.tbl_deep_extend('keep', opts or {}, { on_list = ts_builtin.lsp_document_symbols }))
  end
end)
for server, srv_opts in pairs(lsp_configs) do
  vim.lsp.config(server, srv_opts)
end

vim.api.nvim_create_user_command(
  'RestartKLS',
  function()
    for _, client in ipairs(vim.lsp.get_clients({ name = 'kotlin_language_server' })) do
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
  dependencies = {
    -- {
    --   'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    --   config = function()
    --     local lsp_win = require('lspconfig.ui.windows')
    --     local _default_opts = lsp_win.default_opts
    --     lsp_win.default_opts = function(options)
    --       local opts = _default_opts(options)
    --       opts.border = require('theme_').opts.border_style
    --       return opts
    --     end
    --   end,
    -- },
    {
      'nvimtools/none-ls.nvim', -- for formatters and linters
      dependencies = {
        { "nvim-lua/plenary.nvim" },
      },
      config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
          diagnostics_format = "#{s}: [#{c}] #{m} ",
          sources = {
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,

            -- null_ls.builtins.completion.spell,

            null_ls.builtins.diagnostics.ktlint,
            null_ls.builtins.diagnostics.zsh,

            -- null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.remark,
            null_ls.builtins.formatting.yamlfmt,
            -- null_ls.builtins.formatting.ktlint,
          }

        })
      end,
    },
    {
      'mason-org/mason.nvim',
      build = ':MasonUpdate',
      opts = {
        ui = {
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
        { 'mason-org/mason-lspconfig.nvim' },
        {
          'WhoIsSethDaniel/mason-tool-installer.nvim',
          opts = {
            ensure_installed = vim.tbl_extend(
              'force',
              vim.tbl_keys(lsp_configs),
              mason_install
            ),
          },
        },
      }
    }
  },
}
