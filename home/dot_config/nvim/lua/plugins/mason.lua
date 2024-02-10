return {
	{
		"williamboman/mason.nvim",
		config = true,
		opts = {
			install_root_dir = "/usr/share/nvim/mason",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			local plugins = require("lazy").plugins()
			local deps = vim.tbl_map(function(plugin)
				return plugin.mason_dependencies
			end, plugins)
			deps = vim.tbl_flatten(vim.tbl_values(deps))
			table.sort(deps)
			deps = vim.fn.uniq(deps)

			require("mason-tool-installer").setup({
				ensure_installed = deps,
				run_on_start = false,
			})
		end,
	},
}
