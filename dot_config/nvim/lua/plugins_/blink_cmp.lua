return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    cmdline    = {
      enabled = true,
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        preset = 'inherit',
      },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { 'kind_icon',  'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
          treesitter = { 'lsp' },
        },
        max_height = 50,
      },
      documentation = {
        auto_show = true,
      },
      ghost_text = {
        enabled = true,
      },
    },
    fuzzy      = {
      prebuilt_binaries = {
        force_version = 'v1.2.0',
      },
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },
    keymap     = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      -- ['<Esc>'] = { 'cancel', 'fallback' },
      ["<ESC>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.cancel()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
          end
        end,
      },
    },
    sources    = {
      providers = {
        buffer = {
          opts = {
            get_bufnrs = function()
              return { vim.api.nvim_get_current_buf() }
            end,
            -- get_bufnrs = function()
            --   return vim.tbl_filter(function(bufnr)
            --     return vim.bo[bufnr].buftype == ''
            --   end, vim.api.nvim_list_bufs())
            -- end
          },
        },
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
  },
}
