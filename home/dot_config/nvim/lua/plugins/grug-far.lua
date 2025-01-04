return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			-- options, see Configuration section below
			-- there are no required options atm
			-- engine = 'ripgrep' is default, but 'astgrep' can be specified
		})

		vim.keymap.set({ "n", "v" }, "<leader>gg", "<cmd>lua require('grug-far').open()<cr>")
		vim.keymap.set({ "n", "v" }, "<leader>gG", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand(\"<cword>\") } })<cr>")
	end,
}
