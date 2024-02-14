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
	mason_dependencies = { "stylua", "shellcheck", "shfmt", "prettierd" },
	keys = {
		{ "<leader>f", format, mode = { "n", "x" }, desc = "Format buffer" },
	},
	opts = {
		formatters_by_ft = {
			astro = {  "prettierd" },
			just = { "just" },
			lua = { "stylua" },
			nix = { "alejandra" },
			sh = { "shellcheck", "shfmt" },
		},
	},
}
