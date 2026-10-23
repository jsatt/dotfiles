return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local worktree = require("git-worktree")

    worktree.setup({
      -- Change directory command (default: "cd")
      change_directory_command = "cd",
      -- Update on switch (refresh buffers, etc.)
      update_on_change = true,
      -- Update on change notification
      update_on_change_command = "e .",
      -- Clear jumps on switch
      clearjumps_on_change = true,
      -- Autopush on create (push new branch to remote)
      autopush = false,
    })

    -- Load the Telescope extension
    require("telescope").load_extension("git_worktree")

    -- Hook: run after switching worktrees
    worktree.on_tree_change(function(op, metadata)
      if op == worktree.Operations.Switch then
        print("Switched to worktree: " .. metadata.path)

        -- Stop all LSP clients
        for _, client in ipairs(vim.lsp.get_clients()) do client:stop() end
        -- Restart after a short delay
        vim.defer_fn(function()
          vim.cmd("edit") -- Re-trigger LSP attach
        end, 100)
      end
    end)
  end,
}
