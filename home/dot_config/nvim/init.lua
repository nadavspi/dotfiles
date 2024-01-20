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
lazy.setup("plugins")

-- aesthetics
vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight-moon")

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
