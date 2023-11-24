return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		init = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("lspconfig").lua_ls.setup({})
			require("lspconfig").nil_ls.setup({})
      require("lspconfig")
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "onsails/lspkind-nvim" },
}
