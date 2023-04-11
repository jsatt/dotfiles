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
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'mrjones2014/nvim-ts-rainbow'

    -- VCS
    use 'tpope/vim-fugitive'
    use 'rbong/vim-flog'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Sidebars
    use 'mbbill/undotree'
    use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}}
    use {'stevearc/aerial.nvim'}

    -- Code Completion
    -- use 'tpope/vim-surround'
    use 'kylechui/nvim-surround'
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
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'
    use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters
    use 'towolf/vim-helm'
    -- use 'j-hui/fidget.nvim'

    -- DAP
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'mfussenegger/nvim-dap-python', branch = 'multi-session'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {'rcarriga/nvim-dap-ui'}

    -- Commands
    use {'jedrzejboczar/possession.nvim', requires = { 'nvim-lua/plenary.nvim' }}
    use 'monaqa/dial.nvim'
    use 'tpope/vim-eunuch'
    use 'AndrewRadev/linediff.vim'
    use {'mg979/vim-visual-multi', branch = 'master', setup = function() vim.g.VM_default_mappings = 0 end }
    use 'RRethy/vim-illuminate'
    use 'ojroques/nvim-osc52'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'xiyaowong/telescope-emoji.nvim', requires = {'nvim-telescope/telescope.nvim'}}
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {'norcalli/nvim-colorizer.lua'}
    use {"folke/which-key.nvim"}
    use {'andythigpen/nvim-coverage', requires = {'nvim-lua/plenary.nvim'}}
    use 'rcarriga/nvim-notify'
    use 'taybart/b64.nvim'
    -- use {
    --   "folke/noice.nvim",
    --   requires = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify", "hrsh7th/nvim-cmp"},
    -- }

    -- Vim Config
    use 'klen/nvim-config-local'
    use {'nvim-lualine/lualine.nvim', requires = {'nvim-tree/nvim-web-devicons', opt = true}}
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
  local actions = require('diffview.actions')
  diffview.setup {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff4_mixed",
      },
    },
    keymaps = {
      view =  {
        {'n', '<leader>n', actions.prev_conflict,},
        {'n', '<leader>p', actions.next_conflict },
        {'n', '<leader>gl', actions.conflict_choose('ours') },
        {'n', '<leader>gr', actions.conflict_choose("theirs") },
        {'n', '<leader>gb', actions.conflict_choose("base") },
        {'n', '<leader>ga', actions.conflict_choose("all") },
        {'n', '<leader>gx', actions.conflict_choose("none") },
      },
    },
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
      TRACE = theme.icons.error,
      DEBUG = theme.icons.hint,
      INFO = theme.icons.info,
      WARN =  theme.icons.warn,
      ERROR = theme.icons.error,
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
        '--hidden',
        "--glob=!.git/",
      }
    }
  }
  utils.prepare_module('aerial', function() telescope.load_extension('aerial') end)
  utils.prepare_module('telescope._extensions.dap', function() telescope.load_extension('dap') end)
  utils.prepare_module('telescope-emoji', function() telescope.load_extension('emoji') end)
  utils.prepare_module('notify', function() telescope.load_extension('notify') end)
  utils.prepare_module('possession', function() telescope.load_extension('possession') end)
  -- utils.prepare_module('noice', function() telescope.load_extension('noice') end)
end)


utils.prepare_module('nvim-tree', function(nvim_tree)
  nvim_tree.setup {
    diagnostics = {
      enable = true,
      icons = {
        hint = theme.icons.hint,
        info = theme.icons.info,
        warning = theme.icons.warn,
        error = theme.icons.error,
      },
    },
    actions = {
      change_dir = {
        enable = false,
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
      'hcl',
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
      'terraform',
      'vim',
      'vimdoc',
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
          ["<leader>pd"] = "@block.outer",
        },
      },
    }
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
end)

-- OSC52
-- vim.g.oscyank_max_length = 1000000
utils.prepare_module('osc52', function(osc52)
  osc52.setup {
    max_length = 0,  -- Maximum length of selection
    silent = false,        -- Disable message on successful copy
    trim = true,           -- Trim text before copy
  }
end)

utils.prepare_module('nvim-surround', function(surround)
  surround.setup()
end)

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
    autosave = {
      current = true,
      on_quit = true,
    },
      commands = {
          save = 'SSave',
          load = 'SLoad',
          close = 'SClose',
          delete = 'SDelete',
          show = 'SShow',
          list = 'SList',
          migrate = 'SMigrate',
      },
  }
end)

-- Dial
utils.prepare_module('dial.config', function(dial)
  local augend = require('dial.augend')
  dial.augends:register_group({
    default = {
      augend.constant.new({elements = {"true", "false"}, word=true, cyclic=true, preserve_case=true}),
      augend.integer.alias.decimal_int,
      augend.integer.alias.binary,
      augend.integer.alias.hex,
      augend.integer.alias.octal,
      augend.date.alias["%m/%d/%Y"],
      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%m/%d"],
      augend.date.alias["%H:%M"],
      augend.date.alias["%H:%M:%S"],
      augend.semver.alias.semver,
      augend.constant.new({elements = {"and", "or"}, word=true, cyclic=true, preserve_case=true}),
      augend.constant.new({elements = {"&&", "||"}, word=false, cyclic=true}),
      augend.constant.new({elements = {"on", "off"}, word=true, cyclic=true, preserve_case=true}),
      augend.constant.new({elements = {"yes", "no"}, word=true, cyclic=true, preserve_case=true}),
      augend.constant.new({elements = {"is not", "is"}, word=true, cyclic=true, preserve_case=true}),
    },
  })
end)


-- Gitsigns
utils.prepare_module('gitsigns', function(gitsigns)
  gitsigns.setup {
    signs = {
      add = { text = theme.signs.vcs.add.statuscolumn_text, hl = theme.signs.vcs.add.statuscolumn_hl, numhl = theme.signs.vcs.add.statuscolumn_numhl, linehl = theme.signs.vcs.add.statuscolumn_linehl},
      change = { text = theme.signs.vcs.change.statuscolumn_text, hl = theme.signs.vcs.change.statuscolumn_hl, numhl = theme.signs.vcs.change.statuscolumn_numhl, linehl = theme.signs.vcs.change.statuscolumn_linehl},
      changedelete = { text = theme.signs.vcs.changedelete.statuscolumn_text, hl = theme.signs.vcs.changedelete.statuscolumn_hl, numhl = theme.signs.vcs.changedelete.statuscolumn_numhl, linehl = theme.signs.vcs.changedelete.statuscolumn_linehl},
      delete = { text = theme.signs.vcs.delete.statuscolumn_text, hl = theme.signs.vcs.delete.statuscolumn_hl, numhl = theme.signs.vcs.delete.statuscolumn_numhl, linehl = theme.signs.vcs.delete.statuscolumn_linehl},
      topdelete = { text = theme.signs.vcs.changedelete.statuscolumn_text, hl = theme.signs.vcs.changedelete.statuscolumn_hl, numhl = theme.signs.vcs.changedelete.statuscolumn_numhl, linehl = theme.signs.vcs.changedelete.statuscolumn_linehl},
      untracked = { text = theme.signs.vcs.untracked.statuscolumn_text, },
    },
    numhl = true,
    preview_config = {
      border = 'rounded',
    },
  }
end)


-- Aerial
utils.prepare_module('aerial', function(aerial)
  aerial.setup {
    layout = {
      default_direction = 'prefer_left',
    },
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
