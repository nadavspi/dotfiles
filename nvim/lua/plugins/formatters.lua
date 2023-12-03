return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
			filetype = {
				nix = {
					require("formatter.filetypes.nix").alejandra,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettier,
				},
				json = {
					require("formatter.filetypes.json").prettier,
				},
				markdown = {
					require("formatter.filetypes.markdown").prettier,
				},

				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		vim.keymap.set("n", "<leader>f", "<cmd>FormatWrite<cr>")
	end,
}
