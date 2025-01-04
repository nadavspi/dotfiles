local function format()
	require("conform").format({ lsp_fallback = true }, function()
		if vim.bo.ft == "javascript" or vim.bo.ft == "typescript" then
			vim.cmd.TSToolsOrganizeImports()
			vim.cmd.TSToolsFixAll()
		end
	end)
end

-- :help conform-formatters
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	mason_dependencies = {
		"prettierd",
		"shellcheck",
		"shfmt",
		"stylua",
	},
	keys = {
		{ "<leader>f", format, mode = { "n", "x" }, desc = "Format buffer" },
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		formatters_by_ft = {
			html = { "prettierd" },
			just = { "just" },
			lua = { "stylua" },
			nix = { "alejandra" },
			php = { "easy-coding-standard" },
			sh = { "shellcheck", "shfmt" },
			astro = { "prettier" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			graphql = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
