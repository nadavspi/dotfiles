return {
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			require("leap").add_default_mappings()
			vim.keymap.set("o", "z", "<Plug>(leap-forward)")
			vim.keymap.set("o", "Z", "<Plug>(leap-backward)")
		end,
	},
	{
		"ggandor/flit.nvim",
		dependencies = {
			"ggandor/leap.nvim",
		},
		config = true,
	},
}
