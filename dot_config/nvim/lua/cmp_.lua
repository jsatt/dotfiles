local utils = require('utils_')
local theme = require('theme_')

utils.prepare_module('cmp', function(cmp)
  local snippy = require('snippy')

  local cmp_path_opts = {trailing_slash = true, get_cwd = function(params) return vim.fn.getcwd() end}

  cmp.setup {
    snippet = {
      expand = function(args)
        snippy.expand_snippet(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'snippy' },
      { name = 'nvim_lua' },
    }, {
      { name = 'buffer' },
      { name = 'path', option = cmp_path_opts},
    }),
    window = {
      completion = cmp.config.window.bordered({
        border = 'rounded',
        scrollbar = '┃',
      }),
      documentation = cmp.config.window.bordered({
        border = 'rounded',
        scrollbar = '┃',
      }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu"},
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", theme.kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          snippy = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    experimental = {
      ghost_text = true,
    },
  }

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path', option = cmp_path_opts}
    }, {
      { name = 'cmdline' }
    }),
  })

  -- cmp.setup.filetype('gitcommit', {
  --   sources = cmp.config.sources({
  --     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  --   }, {
  --       { name = 'buffer' },
  --   })
  -- })

end)

utils.prepare_module('snippy', function(snippy)
  snippy.setup({
        mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
  })
end)
