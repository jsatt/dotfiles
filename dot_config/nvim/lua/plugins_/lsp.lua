return {
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
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
  },
}
