return {
	{ "chriskempson/vim-tomorrow-theme" },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
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
		end,
	},
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
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
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
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("projections").setup({
				workspaces = {
					{ "~/src", {} },
				},
			})
			require("telescope").load_extension("projections")
			vim.keymap.set("n", "<leader>fp", function()
				vim.cmd("Telescope projections")
			end)

			-- Autostore session on VimExit
			local Session = require("projections.session")
			vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
				callback = function()
					Session.store(vim.loop.cwd())
				end,
			})

			-- Switch to project if vim was started in a project dir
			local switcher = require("projections.switcher")
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					if vim.fn.argc() == 0 then
						switcher.switch(vim.loop.cwd())
					end
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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
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
	},
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
				escape_quit = true,
			})

			vim.keymap.set("n", "<leader>-", "<Cmd>Lf<CR>")
		end,
		dependencies = { "toggleterm.nvim" },
	},
}
