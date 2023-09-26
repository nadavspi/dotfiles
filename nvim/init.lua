-- core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.visualbell = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.autoread = true
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>")
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.splitbelow = true
vim.o.splitright = true

local lazy = {}
function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require("lazy").setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {}

lazy.setup({
	{ "folke/tokyonight.nvim" },
	{ "nvim-lualine/lualine.nvim", lazy = true },
	{ "tpope/vim-repeat" },
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{ "tpope/vim-unimpaired" },
	{
		"nanotee/zoxide.vim",
		config = function()
			vim.keymap.set("n", "gz", "<cmd>:Z ")
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				disable_insert_on_commit = "auto",
			})
			vim.keymap.set("n", "<leader>gs", "<cmd>:Neogit cwd=%:p:h<cr>")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"gnikdroy/projections.nvim",
		branch = "pre_release",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nyngwang/fzf-lua-projections.nvim",
		},
		config = function()
			require("projections").setup({
				workspaces = {
					{ "~/src", {} },
				},
			})
			vim.keymap.set("n", "<Leader>cp", function()
				require("fzf-lua-p").projects()
			end, NOREF_NOERR_TRUNC)

			local Session = require("projections.session")
			vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
				callback = function()
					Session.store(vim.loop.cwd())
				end,
			})
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					if vim.fn.argc() ~= 0 then
						return
					end
					Session.restore(vim.loop.cwd())
				end,
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"tzachar/highlight-undo.nvim",
		opts = {
			duration = 300,
			undo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "u",
				map = "undo",
				opts = {},
			},
			redo = {
				hlgroup = "HighlightUndo",
				mode = "n",
				lhs = "<C-r>",
				map = "redo",
				opts = {},
			},
			highlight_for_count = true,
		},
	},
	{ "gpanders/editorconfig.nvim" },
	{ "wellle/targets.vim" },
	{ "kana/vim-textobj-indent", dependencies = { "kana/vim-textobj-user" } },
	{ "jceb/vim-textobj-uri", dependencies = { "kana/vim-textobj-user" } },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
		dependencies = {
			"williamboman/mason-lspconfig",
			"neovim/nvim-lspconfig",
		},
	},
	{ "neovim/nvim-lspconfig" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			local ls = require("luasnip")
			local snip = ls.snippet
			local func = ls.function_node

			local today = function()
				return { "[[" .. os.date("%Y-%m-%d-%A") .. "]]" }
			end

			ls.add_snippets(nil, {
				all = {
					snip({
						trig = "today",
						namr = "today",
						dscr = "Link to today's daily note",
					}, {
						func(today, {}),
					}),
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "calc" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "text",
						menu = {
							nvim_lsp = "[LSP]",
							calc = "[Calc]",
							nvim_lua = "[Lua]",
							path = "[Path]",
							buffer = "[Buffer]",
							omni = "[Omni]",
						},
					}),
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{ "onsails/lspkind-nvim" },
	{
		"mhartington/formatter.nvim",
		config = function()
			local util = require("formatter.util")
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
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
	},
	{
		"vimwiki/vimwiki",
		lazy = false,
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/Notes/",
					syntax = "markdown",
					ext = ".md",
					diary_rel_path = "DailyNotes/",
				},
			}
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_conceallevel = 0
		end,
		dependencies = {
			"ibhagwan/fzf-lua",
		},
	},
	{
		"epwalsh/obsidian.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
		},
		opts = {
			dir = "~/Documents/Notes",

			daily_notes = {
				folder = "DailyNotes",
				date_format = "%Y-%m-%d-%A",
			},

			disable_frontmatter = true,

			completion = {
				nvim_cmp = true,
				min_chars = 2,
				-- Where to put new notes created from completion. Valid options are
				--  * "current_dir" - put new notes in same directory as the current buffer.
				--  * "notes_subdir" - put new notes in the default notes subdirectory.
				new_notes_location = "notes_subdir",

				-- Whether to add the output of the node_id_func to new notes in autocompletion.
				-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
				prepend_note_id = false,
			},
			mappings = {},
		},
		init = function()
			vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { silent = true })
			vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { silent = true })
			vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { silent = true })
			vim.keymap.set("n", "<leader>og", "<cmd>ObsidianSearch<CR>", { silent = true })

			function fzf_taskwiki_pending()
				require("fzf-lua").fzf_exec("rg '^\\s*\\* \\[ \\]'", {
					actions = require("fzf-lua").defaults.actions.files,
					cwd = "~/Documents/Notes",
					previewer = "builtin",
				})
			end
			vim.keymap.set("n", "<leader>op", fzf_taskwiki_pending, { desc = "Show pending tasks" })
		end,
	},
	{ "tools-life/taskwiki", dependencies = { "vimwiki/vimwiki" } },
	{
		"kdheepak/lazygit.nvim",
		keys = { "<leader>gS" },
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>LazyGitCurrentFile<cr>")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"0x00-ketsu/autosave.nvim",
		events = { "InsertLeave", "TextChanged" },
		config = function()
			require("autosave").setup({})
		end,
	},
	{ "akinsho/toggleterm.nvim", lazy = true, version = "*", config = true },
	{
		"lmburns/lf.nvim",
		config = function()
			vim.g.lf_netrw = 1

			require("lf").setup({
				border = "rounded",
			})

			vim.keymap.set("n", "<leader>-", "<Cmd>Lf<CR>")
		end,
		dependencies = { "toggleterm.nvim" },
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})

			vim.keymap.set("n", "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gG", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })

			function files_git_or_cwd(opts)
				if not opts then
					opts = {}
				end
				opts.cwd = require("fzf-lua.path").git_root(vim.loop.cwd(), true) or vim.loop.cwd()
				opts.fzf_cli_args = ('--header="cwd = %s"'):format(vim.fn.shellescape(opts.cwd))
				require("fzf-lua").files(opts)
			end
			vim.api.nvim_create_user_command("Files", files_git_or_cwd, {})
			vim.keymap.set("n", "<c-P>", "<cmd>Files<CR>", { silent = true })
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
			vim.keymap.set("o", "z", "<Plug>(leap-forward-to)")
			vim.keymap.set("o", "Z", "<Plug>(leap-backward-to)")
		end,
	},
	{ "knubie/vim-kitty-navigator" },
})

-- aesthetics
vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight")
require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
})

-- clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P"')
vim.keymap.set("n", "<leader>cf", '<cmd>let @" = expand("%:p")<cr>', { desc = "Copy full path" })

-- insert mode maps
vim.keymap.set("i", "<C-e>", "<Esc>A")

-- meta maps
vim.keymap.set("n", "gev", "<cmd>edit $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>write<cr>")
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- window management
vim.keymap.set("n", "<leader>wc", ":close<cr>", { silent = true })
vim.keymap.set("n", "<leader>wo", ":only<cr>", { silent = true })
vim.keymap.set("n", "<leader>ws", ":split<cr>", { silent = true })
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { silent = true })
vim.keymap.set("n", "<leader>wt", ":tabnew<cr>", { silent = true })
vim.keymap.set("n", "<leader>1", "1gt<cr>")
vim.keymap.set("n", "<leader>2", "2gt<cr>")
vim.keymap.set("n", "<leader>3", "3gt<cr>")
vim.keymap.set("n", "<leader>4", "4gt<cr>")
vim.keymap.set("n", "<leader>5", "5gt<cr>")
vim.keymap.set("n", "<leader>6", "6gt<cr>")
vim.keymap.set("n", "<leader>7", "7gt<cr>")
vim.keymap.set("n", "<leader>8", "8gt<cr>")

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")

vim.g.vimwiki_list = {
	{
		path = "~/Documents/Notes/",
		syntax = "markdown",
		ext = ".md",
		diary_rel_path = "DailyNotes/",
	},
}
vim.g.vimwiki_key_mappings = {
	links = 0,
}
vim.g.taskwiki_suppress_mappings = true

pcall(require, "local")
