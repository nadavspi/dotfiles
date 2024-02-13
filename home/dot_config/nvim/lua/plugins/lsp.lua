-- much here from https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/lsp-config.lua

-- since nvim-lspconfig and mason.nvim use different package names
-- mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
local lspToMasonMap = {
	astro = "astro-language-server",
	bashls = "bash-language-server",
	biome = "biome",
	cssls = "css-lsp",
	cssmodules_ls = "cssmodules-language-server",
	emmet_language_server = "emmet-language-server",
	jsonls = "json-lsp",
	lua_ls = "lua-language-server",
	marksman = "marksman", -- markdown lsp
	tailwindcss = "tailwindcss-language-server",
	taplo = "taplo",
	yamlls = "yaml-language-server",
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt#L46
local servers = {}
for lspName, _ in pairs(lspToMasonMap) do
	servers[lspName] = {}
end

servers.cssmodules_ls = {
	capabilities = {
		definitionProvider = false,
	},
}

servers.biome = {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
	end,
}
-- https://github.com/olrtg/emmet-language-server?tab=readme-ov-file#neovim
-- https://docs.emmet.io/customization/preferences/
servers.emmet_language_server = {
	filetypes = { "css", "html", "javascript", "javascriptreact", "scss", "typescriptreact" },
	init_options = {
		showSuggestionsAsSnippets = true, -- so it works with luasnip
	},
}

servers.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
local tsserverConfig = {
	settings = {
		-- specific to typescript-tools.nvim
		complete_function_calls = true,
		tsserver_plugins = {
			"@styled/typescript-styled-plugin",
		},

		-- enable checking javascript without a `jsconfig.json`
		implicitProjectConfiguration = { -- DOCS https://www.typescriptlang.org/tsconfig
			checkJs = true,
			target = "ES2022", -- JXA is compliant with most of ECMAScript: https://github.com/JXA-Cookbook/JXA-Cookbook/wiki/ES6-Features-in-JXA
		},

		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			},
		},
	},
	on_attach = function(client)
		-- Disable formatting in favor of biome
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
tsserverConfig.settings.javascript = tsserverConfig.settings.typescript

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		mason_dependencies = vim.tbl_values(lspToMasonMap),
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

			-- Enable snippets-completion (nvim-cmp) and folding (nvim-ufo)
			local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
			lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
			lspCapabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

			for lsp, server in pairs(servers) do
				server.capabilities = lspCapabilities
				require("lspconfig")[lsp].setup(server)
			end
		end,
	},
	{ "neovim/nvim-lspconfig", dependencies = { "folke/neodev.nvim" } },
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup(tsserverConfig)
		end,
	},
}
