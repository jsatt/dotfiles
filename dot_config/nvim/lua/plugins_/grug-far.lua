return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({
      icons ={
        enabled = false, -- try enabling again in the future, causes error due to glyph widths
      },
    });
  end
}
