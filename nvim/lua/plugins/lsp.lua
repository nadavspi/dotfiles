return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		init = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("UserLspConfig", {}),
					callback = function(ev)
						-- Enable completion triggered by <c-x><c-o>
						vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

						-- Buffer local mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local opts = { buffer = ev.buf }
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
						vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
						vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
						vim.keymap.set("n", "<leader>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
						end, opts)
						vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						-- vim.keymap.set("n", "<leader>f", function()
						-- 	vim.lsp.buf.format({ async = true })
						-- end, opts)
					end,
				})
			end)

			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			-- servers go here
			require("lspconfig").nil_ls.setup({})
			require("lspconfig").rust_analyzer.setup({})
			require("lspconfig").bashls.setup({})
		end,
	},
	{ "neovim/nvim-lspconfig", dependencies = { "folke/neodev.nvim" } },
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },
}
