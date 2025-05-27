return {
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
	opts = {
		snippetDir = vim.fn.stdpath("config") .. "/snippets",
	}
}
