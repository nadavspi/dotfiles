return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		local function git_root_or_cwd()
			-- Use the current buffer's path as the starting point for the git search
			local current_file = vim.api.nvim_buf_get_name(0)
			local current_dir
			local cwd = vim.fn.getcwd()
			if current_file == "" then
				current_dir = cwd
			else
				-- Extract the directory from the current file's path
				current_dir = vim.fn.fnamemodify(current_file, ":h")
			end

			-- Find the Git root directory from the current file's path
			local git_root =
				vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
			if vim.v.shell_error ~= 0 then
				-- not a git repo
				return cwd
			end
			return git_root
		end

		local function live_grep()
			local dir = git_root_or_cwd()
			builtin.live_grep({
				search_dirs = { dir },
			})
		end
		local function grep_string()
			local dir = git_root_or_cwd()
			require("telescope.builtin").grep_string({
				search_dirs = { dir },
			})
		end
		local function find_files()
			require("telescope.builtin").find_files({
				cwd = git_root_or_cwd(),
			})
		end
		local function find_notes()
			require("telescope.builtin").find_files({
				cwd = "~/Documents/Archive/10-19 Personal documents/18 Notes"
			})
		end

		vim.keymap.set("n", "<leader>ff", find_files, {})
		vim.keymap.set("n", "<leader>gg", live_grep, {})
		vim.keymap.set("n", "<leader>gG", grep_string, {})
		vim.keymap.set("n", "<leader>b", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>/", function()
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
