return {
	{
		"Lilja/zellij.nvim",
		config = function()
			require("zellij").setup({
				vimTmuxNavigatorKeybinds = true,
				replaceVimWindowNavigationKeybinds = false,
			})
		end,
	},
}
