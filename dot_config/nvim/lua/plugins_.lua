local utils = require('utils_')
local theme = require('theme_')

-- Automatically install packer
local packer_install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

utils.prepare_module('packer', function(packer)
  -- Autocommand that reloads neovim whenever you save the plugins.lua file
  local packer_user_config = vim.api.nvim_create_augroup('packer_user_config', {clear = true})
  vim.api.nvim_create_autocmd('BufWritePost', {pattern = {'plugins_.lua'}, command = 'source <afile> | PackerSync', group=packer_user_config})

  -- Have packer use a popup window
  packer.init {
    display = {
      keybindings = {
        quit = '<Esc>',
      },
      prompt_border = 'rounded',
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  -- Install your plugins here
  packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- Have packer manage itself

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'p00f/nvim-ts-rainbow'

    -- VCS
    use 'tpope/vim-fugitive'
    use 'rbong/vim-flog'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Sidebars
    use 'mbbill/undotree'
    use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'stevearc/aerial.nvim'}

    -- Code Completion
    -- use 'tpope/vim-surround'
    use 'kylechui/nvim-surround'
    use 'mattn/emmet-vim'
    use 'numToStr/Comment.nvim'
    use 'dcampos/nvim-snippy'
    use 'honza/vim-snippets'

    -- cmp plugins
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'dcampos/cmp-snippy'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions

    -- LSP
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'j-hui/fidget.nvim'

    -- DAP
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'mfussenegger/nvim-dap-python', branch = 'multi-session'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {'rcarriga/nvim-dap-ui'}

    -- Commands
    use 'lewis6991/impatient.nvim'
    use {'jedrzejboczar/possession.nvim', requires = { 'nvim-lua/plenary.nvim' }}
    use 'AndrewRadev/switch.vim'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-speeddating'
    use 'AndrewRadev/linediff.vim'
    use {'mg979/vim-visual-multi', branch = 'master'}
    use 'RRethy/vim-illuminate'
    -- use {'ojroques/vim-oscyank', branch = 'main'}
    use 'ojroques/nvim-osc52'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'xiyaowong/telescope-emoji.nvim', requires = {'nvim-telescope/telescope.nvim'}}
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {'norcalli/nvim-colorizer.lua'}
    use {"folke/which-key.nvim"}
    use {'andythigpen/nvim-coverage', requires = {'nvim-lua/plenary.nvim'}}
    use 'rcarriga/nvim-notify'

    -- Vim Config
    use 'klen/nvim-config-local'
    use 'editorconfig/editorconfig-vim'
    use 'nvim-lualine/lualine.nvim'
    use 'sainnhe/sonokai'
    use 'stevearc/dressing.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end)
end)

utils.prepare_module('dressing', function(dressing)
  dressing.setup({
  })
end)

utils.prepare_module('diffview', function(diffview)
  diffview.setup {
    enhanced_diff_hl = true,
  }
end)

utils.prepare_module('colorizer', function(colorizer)
  colorizer.setup()
end)

utils.prepare_module('which-key', function(which_key)
  which_key.setup()
end)

utils.prepare_module('notify', function(notify)
  notify.setup {
    stages = 'slide',
    icons = {
      TRACE = theme.signs.error.text,
      DEBUG = theme.signs.hint.text,
      INFO = theme.signs.info.text,
      WARN =  theme.signs.warn.text,
      ERROR = theme.signs.error.text,
    }

  }
  vim.notify = notify
end)

utils.prepare_module('telescope', function(telescope)
  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color', 'never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      }
    }
  }
	utils.prepare_module('aerial', function() telescope.load_extension('aerial') end)
	utils.prepare_module('telescope._extensions.dap', function() telescope.load_extension('dap') end)
  utils.prepare_module('telescope-emoji', function() telescope.load_extension('emoji') end)
  utils.prepare_module('notify', function() telescope.load_extension('notify') end)
	utils.prepare_module('possession', function() telescope.load_extension('possession') end)
end)


utils.prepare_module('nvim-tree', function(nvim_tree)
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  nvim_tree.setup {
    diagnostics = {
      enable = true,
      icons = {
        hint = theme.signs.hint.text,
        info = theme.signs.info.text,
        warning = theme.signs.warn.text,
        error = theme.signs.error.text,
      },
    },
    view = {
      mappings = {
        list = {
          {key = 'S', cb = tree_cb('system_open')},
          {key = 's', cb = tree_cb('split')},
          {key = 'v', cb = tree_cb('vsplit')},
          {key = 't', cb = tree_cb('tabnew')},
        },
      },
    },
  }
end)

utils.prepare_module('Comment', function(comment)
  comment.setup {
    ignore='^$',
  }
end)

utils.prepare_module('nvim-treesitter.configs', function(ts_configs)
  ts_configs.setup {
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dockerfile',
      'html',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'vim',
      'yaml',
    },
    highlight = {
      enable = true
    },
    indent = {
      enable = true,
      disable = {'python'},
    },
    incremental_selection = {
      enable = true,
    },

    -- TS Plugins
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
          ["af"] = "@function.outer",  -- function or method
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",  -- class
          ["ic"] = "@class.inner",
          ['ax'] = '@block.outer',  -- function or class
          ['ix'] = '@block.inner',
          ['ai'] = '@conditional.outer', -- if statment
          ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer', -- loop, but not comprehensions
          ['il'] = '@loop.inner',
          -- call = function call args
          -- statement - single "line", even if split across lines
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['ma'] = '@parameter.inner', -- single call arg
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
        set_jumps = true, -- whether to set jumps in the jumplist
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
        border = 'rounded',
        peek_definition_code = {
          ["pd"] = "@block.outer",
        },
      },
    }
  }
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end)

-- OSC52
-- vim.g.oscyank_max_length = 1000000
utils.prepare_module('osc52', function(osc52)
  osc52.setup {
    max_length = 1000000,  -- Maximum length of selection
    silent = false,        -- Disable message on successful copy
    trim = true,           -- Trim text before copy
  }
end)

-- ZenCoding
vim.g.user_emmet_expandabbr_key='<c-e>' -- expand w/ Ctrl-e

utils.prepare_module('nvim-surround', function(surround)
  surround.setup()
end)

-- Lualine
utils.prepare_module('lualine', function(lualine)
  lualine.setup {
    options = {
      theme = theme.lualine_theme,
      globalstatus = true,
      section_separators = {
        right = '',
        left = '',
      },
      component_separators = {
        right = '',
        left = '',
      },
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        {'branch', icon=''},
        {'diff',
          symbols = {
            added = theme.gitsigns.add.text .. ' ',
            modified = theme.gitsigns.change.text .. ' ',
            removed = theme.gitsigns.delete.text..' ',
          },
          diff_color = {
            added = theme.gitsigns.add.hl,
            modified = theme.gitsigns.change.hl,
            removed = theme.gitsigns.delete.hl,
          }
        }
      },
      lualine_c = {
        {'filename', path=1, symbols={readonly=''}},
        'aerial',
      },
      lualine_x = {
        {
          'diagnostics',
          always_visible=true,
          diagnostics_color = {
            error = theme.signs.error.ll_name,
            warn  = theme.signs.warn.ll_name,
            info  = theme.signs.info.ll_name,
            hint  = theme.signs.hint.ll_name,
          },
          symbols = {
            error = theme.signs.error.text .. ' ',
            warn = theme.signs.warn.text .. ' ',
            info = theme.signs.info.text .. ' ',
            hint = theme.signs.hint.text .. ' ',
          },
        },
      },
      lualine_y = {
        'filetype',
        'encoding',
        'fileformat'
      },
      lualine_z = {
      'progress',
       {function() return ':%3l/%3L☰ :%-2v' end},  -- full file location
      },
    },
    tabline = {
      lualine_a = {{'tabs', mode=2, max_length = vim.o.columns}},
    },
    extensions = {
      'fugitive',
      'nvim-tree',
      'aerial',
    },
  }
end)

vim.g.VM_default_mappings = 0

--  local vimrc
utils.prepare_module('config-local', function(config_local)
  config_local.setup {
    config_files = {'.nvimrc.lua', '.nvimrc'},
    lookup_parents = true,
  }
end)

-- Possession
utils.prepare_module('possession', function(possession)
  possession.setup {
      commands = {
          save = 'SSave',
          load = 'SLoad',
          delete = 'SDelete',
          show = 'SShow',
          list = 'SList',
          migrate = 'SMigrate',
      },
  }
end)

-- Switch
vim.g.switch_mapping = '='
vim.g.switch_reverse_mapping = '+'
vim.g.switch_no_builtins = 1
vim.g.switch_custom_definitions = {
  {'&&', '||'},
  {['\\<and\\>'] = 'or', ['\\<or\\>'] = 'and'},
  {['\\<on\\>'] = 'off', ['\\<off\\>'] = 'on'},
  {['\\<On\\>'] = 'Off', ['\\<Off\\>'] = 'On'},
  {['\\<yes\\>'] = 'no', ['\\<no\\>'] = 'yes'},
  {['\\<Yes\\>'] = 'No', ['\\<No\\>'] = 'Yes'},
  {['\\<true\\>'] = 'false', ['\\<false\\>'] = 'true'},
  {['\\<True\\>'] = 'False', ['\\<False\\>'] = 'True'},
  {
    ['\\(\\k\\+\\) is \\(not\\)\\@!\\(\\k\\+\\)'] = '\\1 is not \\3',
    ['\\(\\k\\+\\) is not \\(\\k\\+\\)'] = '\\1 is \\2',
  },
}


-- Gitsigns
utils.prepare_module('gitsigns', function(gitsigns)
  gitsigns.setup {
    signs = theme.gitsigns,
    numhl = true,
    preview_config = {
      border = 'rounded',
    },
  }
end)


-- Aerial
utils.prepare_module('aerial', function(aerial)
  aerial.setup {
    default_direction = 'prefer_left',
    icons = theme.kind_icons,
    link_folds_to_tree = true,
    link_tree_to_folds = true,
    manage_folds = true,
    nerd_font=true,
  }
end)

-- Coverage
utils.prepare_module('coverage', function(coverage)
  coverage.setup {
    highlights = {
      covered = { link = 'GreenSign' },   -- supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { link = 'RedSign' },
    },
  }
end)
