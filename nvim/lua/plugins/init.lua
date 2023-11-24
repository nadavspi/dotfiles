return {
	{ "chriskempson/vim-tomorrow-theme" },
	{ "nvim-lualine/lualine.nvim", lazy = true },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-sleuth" },
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
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					nix = {
						require("formatter.filetypes.nix").nixfmt,
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
	},
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
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

			local function files_git_or_cwd(opts)
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
}
