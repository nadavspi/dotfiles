-- much here from https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/lsp-config.lua

-- since nvim-lspconfig and mason.nvim use different package names
-- mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
local lspToMasonMap = {
	antlersls = "antlers-language-server",
	astro = "astro-language-server",
	bashls = "bash-language-server",
	cssls = "css-lsp",
	cssmodules_ls = "cssmodules-language-server",
	emmet_language_server = "emmet-language-server",
	intelephense = "intelephense",
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

-- https://github.com/olrtg/emmet-language-server?tab=readme-ov-file#neovim
-- https://docs.emmet.io/customization/preferences/
servers.emmet_language_server = {
	filetypes = { "css", "html", "javascript", "javascriptreact", "scss", "typescriptreact" },
	init_options = {
		showSuggestionsAsSnippets = true, -- so it works with luasnip
	},
}

servers.intelephense = {
	settings = {
		intelephense = {
			stubs = {
				"wordpress-globals",
				"wordpress-stubs",
			},
			environment = {
				includePaths = { "vendor/php-stubs/" },
			},
		},
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

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		mason_dependencies = vim.tbl_values(lspToMasonMap),
		init = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

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
		-- https://github.com/pmizio/typescript-tools.nvim
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				settings = {
					complete_function_calls = true,

					tsserver_plugins = {
						"@styled/typescript-styled-plugin",
					},

					-- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
					tsserver_file_preferences = {
						includeCompletionsForImportStatements = true,
					},

					-- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
					tsserver_format_options = {

					},

					-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
					-- "remove_unused_imports"|"organize_imports") -- or string "all"
					-- to include all supported code actions
					-- specify commands exposed as code_actions
					expose_as_code_action = "all",

					-- possible values: ("off"|"all"|"implementations_only"|"references_only")
					code_lens = "off",

					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					},

					-- enable checking javascript without a `jsconfig.json`
					implicitProjectConfiguration = { -- DOCS https://www.typescriptlang.org/tsconfig
						checkJs = true,
						target = "ES2022",
					},
				},
				on_attach = function(client) end,
			})
		end,
	},
	{ "aznhe21/actions-preview.nvim" }
}
