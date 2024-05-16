return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:?]],
    },
    search = {
      pattern = [[\b(KEYWORDS):?]],
    },
  }
}
