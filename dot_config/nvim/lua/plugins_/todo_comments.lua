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
    keywords = {
      FIX = { icon = "" },
      TODO = { icon = "" },
      HACK = { icon = "" },
      WARN = { icon = "" },
      PERF = { icon = "" },
      NOTE = { icon = "" },
    }
  }
}
