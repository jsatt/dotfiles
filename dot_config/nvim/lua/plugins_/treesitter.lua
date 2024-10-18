return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'mrjones2014/nvim-ts-rainbow',
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'diff',
      'dockerfile',
      'gitcommit',
      'gitignore',
      'git_config',
      'git_rebase',
      'graphql',
      'hcl',
      'html',
      'htmldjango',
      'ini',
      'javascript',
      'json',
      'kotlin',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'passwd',
      'pem',
      'python',
      'query',
      'regex',
      'terraform',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    highlight = {
      enable = true
    },
    indent = {
      enable = true,
      disable = { 'python' },
    },
    incremental_selection = {
      enable = true,
    },
    -- Plugins
    rainbow = {
      enable = true,
      colors = {
        '#cc241d', '#a89984', '#b16286', '#d79921', '#689d6a', '#d65d0e', '#458588', '#008000',
        '#ff0000', '#0000ff',
      },
      termcolors = {
        'green', 'red', 'yellow', 'blue', 'brown', 'darkmagenta', 'darkcyan', 'darkgray',
        'darkgreen', 'lightyellow', 'darkblue', 'magenta', 'cyan',
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",      -- function or method
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",         -- class
          ["ic"] = "@class.inner",
          ['ax'] = '@block.outer',         -- function or class
          ['ix'] = '@block.inner',
          ['ai'] = '@conditional.outer',   -- if statment
          ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer',          -- loop, but not comprehensions
          ['il'] = '@loop.inner',
          -- call = function call args
          -- statement - single "line", even if split across lines
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['ma'] = '@parameter.inner',   -- single call arg
          ['mf'] = '@function.outer',
          ['mc'] = '@class.outer',
        },
        swap_previous = {
          ['Ma'] = '@parameter.inner',
          ['Mf'] = '@function.outer',
          ['Mc'] = '@class.outer',
        }
      },
      move = {
        enable = true,
        set_jumps = true,   -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = require('theme_').opts.border_style,
        peek_definition_code = {
          ["<leader>pd"] = "@block.outer",
        },
      },
    }
  },
  init = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
}
