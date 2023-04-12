return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local actions = require('diffview.actions')
    require('diffview').setup {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff4_mixed",
        },
      },
      keymaps = {
        view = {
          { 'n', '<leader>n',  actions.prev_conflict },
          { 'n', '<leader>p',  actions.next_conflict },
          { 'n', '<leader>gl', actions.conflict_choose('ours') },
          { 'n', '<leader>gr', actions.conflict_choose("theirs") },
          { 'n', '<leader>gb', actions.conflict_choose("base") },
          { 'n', '<leader>ga', actions.conflict_choose("all") },
          { 'n', '<leader>gx', actions.conflict_choose("none") },
          { 'n', '<leader>gu', actions.refresh_files },
        },
      },
    }
  end,
}
