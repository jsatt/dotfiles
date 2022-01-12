local utils = require('common_')

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
  vim.cmd [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins_.lua source <afile> | PackerSync
    augroup end
  ]]

  -- Have packer use a popup window
  packer.init {
    display = {
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
    use 'p00f/nvim-ts-rainbow'

    -- VCS
    use 'tpope/vim-fugitive'
    use 'rbong/vim-flog'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Sidebars
    use 'mbbill/undotree'
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
    }

    -- Code Completion
    use 'tpope/vim-surround'
    use 'mattn/emmet-vim'
    use 'numToStr/Comment.nvim'

    -- cmp plugins
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions

    -- LSP
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    -- use 'williamboman/nvim-lsp-installer' -- simple to use language server installer
    use {'williamboman/nvim-lsp-installer', branch='dont-prepare-root-dir'}
    use 'tamago324/nlsp-settings.nvim' -- language server settings defined in json for
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters

    -- Commands
    use 'AndrewRadev/switch.vim'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-speeddating'
    use 'AndrewRadev/linediff.vim'
    use {'mg979/vim-visual-multi', branch = 'master'}
    use 'RRethy/vim-illuminate'
    use {'ojroques/vim-oscyank', branch = 'main'}
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}

    -- Vim Config
    use 'LucHermitte/lh-vim-lib'
    use 'LucHermitte/local_vimrc'
    use 'editorconfig/editorconfig-vim'
    use 'nvim-lualine/lualine.nvim'
    use 'sainnhe/sonokai'

    -- Python
    use 'klen/python-mode'
    use 'jeetsukumaran/vim-pythonsense'
    use 'mgedmin/coverage-highlight.vim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end)
end)


utils.prepare_module('telescope', function(telescope)
  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        'ag',
        '--nocolor',
        '--noheading',
        '--filename',
        '--numbers',
        '--column',
        '--smart-case',
      }
    }
  }
end)


utils.prepare_module('nvim-tree', function(nvim_tree)
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  nvim_tree.setup {
    view = {
      mappings = {
        list = {
          {key = 'S', cb = tree_cb('system_open')},
          {key = 's', cb = tree_cb('split')},
          {key = 'v', cb = tree_cb('vsplit')},
          {key = 't', cb = tree_cb('tabnew')},
        }
      }
    }
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
      'query',
      'python',
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
    }
  }
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end)

-- OSC52
vim.g.oscyank_max_length = 1000000

-- ZenCoding
vim.g.user_emmet_expandabbr_key='<c-e>' -- expand w/ Ctrl-e

-- Lualine
utils.prepare_module('lualine', function(lualine)
  local lualine_theme = require('lualine_theme')
  lualine.setup {
    options = {
      theme = lualine_theme,
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
            added = utils.gitsigns.add.text .. ' ',
            modified = utils.gitsigns.change.text .. ' ',
            removed = utils.gitsigns.delete.text..' ',
          },
          diff_color = {
            added = utils.gitsigns.add.hl,
            modified = utils.gitsigns.change.hl,
            removed = utils.gitsigns.delete.hl,
          }
        }
      },
      lualine_c = {
        {'filename', path=1, symbols={readonly=''}},
        'g:coc_status',
      },
      lualine_x = {
        'filetype',
      },
      lualine_y = {
        {
          'diagnostics',
          always_visible=true,
          diagnostics_color = {
            error = utils.signs.error.name,
            warn  = utils.signs.warn.name,
            info  = utils.signs.info.name,
            hint  = utils.signs.hint.name,
          },
          symbols = {
            error = utils.signs.error.text .. ' ',
            warn = utils.signs.warn.text .. ' ',
            info = utils.signs.info.text .. ' ',
            hint = utils.signs.hint.text .. ' ',
          },
        },
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
    extensions = {'fugitive', 'nvim-tree'},
  }
end)

vim.g.VM_default_mappings = 0

--  local vimrc
vim.g.local_vimrc = { '.vimlocal', '_vimrc_local.vim' }
vim.fn['lh#local_vimrc#munge']('whitelist', vim.env.HOME .. '/dev')

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

-- Python Mode
vim.g.pymode_options_max_line_length = 89
vim.g.pymode_options_colorcolumn = 0
vim.g.pymode_lint = 0
vim.g.pymode_rope = 0
vim.g.pymode_virtualenv = 1
vim.g.pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT'
vim.g.pymode_python = 'python3'
vim.g.pymode_doc = 0
vim.g.pymode_doc_bind = ''


-- Gitsigns
utils.prepare_module('gitsigns', function(gitsigns)
  gitsigns.setup {
    signs = utils.gitsigns,
    numhl = true,
    preview_config = {
      border = 'rounded',
    },
  }
end)
