-- core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.backspace = indent, eol, start
vim.opt.visualbell = true
vim.opt.undofile = true
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
	{ "tpope/vim-surround" },
	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-commentary" },
	{ "gpanders/editorconfig.nvim" },
	{ "wellle/targets.vim" },
	{ "kana/vim-textobj-indent", dependencies = { "kana/vim-textobj-user" } },
	{ "jceb/vim-textobj-uri", dependencies = { "kana/vim-textobj-user" } },
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
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/Notes/",
					syntax = "markdown",
					ext = ".md",
					diary_rel_path = "DailyNotes/",
				},
			}
			vim.g.vimwiki_ext2syntax = {}
			vim.keymap.set(
				"n",
				"gn",
				"<cmd>lua require('fzf-lua').files({ cwd = '~/Documents/Notes' })<CR>",
				{ silent = true }
			)
		end,
		dependencies = {
			"ibhagwan/fzf-lua",
		},
	},
	{ "tools-life/taskwiki", dependencies = { "vimwiki/vimwiki" } },
	{
		"kdheepak/lazygit.nvim",
		keys = { "<leader>gs" },
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
		keys = "-",
		config = function()
			-- This feature will not work if the plugin is lazy-loaded
			require("lf").setup({
				border = "rounded",
			})

			vim.keymap.set("n", "-", "<Cmd>Lf<CR>")
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

			vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
			vim.keymap.set("n", "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
			vim.keymap.set("n", "<leader>gG", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true })
		end,
	},
	{ "ggandor/lightspeed.nvim" },
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

-- insert mode maps
vim.keymap.set("i", "<C-e>", "<Esc>A")

-- meta maps
vim.keymap.set("n", "gev", "<cmd>edit $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>write<cr>")
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- line 220
-- window management
vim.keymap.set("n", "<leader>wc", ":close<cr>", { silent = true })
vim.keymap.set("n", "<leader>wo", ":only<cr>", { silent = true })
vim.keymap.set("n", "<leader>ws", ":split<cr>", { silent = true })
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { silent = true })
vim.keymap.set("n", "<leader>t", ":tabnew<cr>", { silent = true })
vim.keymap.set("n", "<leader>1", "1gt<cr>")
vim.keymap.set("n", "<leader>2", "2gt<cr>")
vim.keymap.set("n", "<leader>3", "3gt<cr>")
vim.keymap.set("n", "<leader>4", "4gt<cr>")
vim.keymap.set("n", "<leader>5", "5gt<cr>")
vim.keymap.set("n", "<leader>6", "6gt<cr>")
vim.keymap.set("n", "<leader>7", "7gt<cr>")
vim.keymap.set("n", "<leader>8", "8gt<cr>")
vim.g.vimwiki_list = {
	{
		path = "~/Documents/Notes/",
		syntax = "markdown",
		ext = ".md",
		diary_rel_path = "DailyNotes/",
	},
}
