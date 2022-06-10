local utils = require('utils_')
local theme = require('theme_')

utils.prepare_module('cmp', function(cmp)
  -- local cmp_buffer = require('cmp_buffer')
  -- local luasnip = require('luasnip')
  -- require('luasnip.loaders.from_vscode').load()
  -- luasnip.filetypeclass_name_extend('python', {'django'})
  local snippy = require('snippy')

  local cmp_default_config = require('cmp.config.default')()
  local cmp_path_opts = {trailing_slash = true }

  cmp.setup {
    snippet = {
      expand = function(args)
        snippy.expand_snippet(args.body)
        -- luasnip.lsp_expand(args.body)
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
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snippy.can_expand_or_advance() then
          snippy.expand_or_advance()
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
        else
          fallback()
        end
      end),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif snippy.can_jump(-1) then
          snippy.previous()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
        else
          fallback()
        end
      end),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'luasnip' },
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
      mttinields = { "kind", "abbr", "menu"},
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", theme.kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', theme.kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          snippy = "[Snippet]",
          -- luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
    sorting = {
      comparators = vim.list_extend(
        {
          -- function(...) return cmp_buffer:compare_locality(...) end,
        },
        cmp_default_config.sorting.comparators
      ),
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
    })
  })

end)
