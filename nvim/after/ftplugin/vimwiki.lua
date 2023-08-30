vim.keymap.set("n", "<cr>", "<cmd>ObsidianFollowLink<cr>", { buffer = true })

function fzf_obsidian_link()
	function insert_at_cursor(selected)
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local wikilink = " [[" .. selected[1] .. "]] "
		vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { wikilink })
		vim.api.nvim_win_set_cursor(0, { row, col + string.len(wikilink) })
		vim.cmd("startinsert")
	end

	require("fzf-lua").fzf_exec(
		"{ rg -oNI '\\[\\[[^]]*]]' | grep -oh '[^][]\\{1,\\}' | sed 's/^ *//;s/ $//'; find -type f -name '*.md' | sed 's#.*/##; s#[.][^.]*$##'; } | sort | uniq",
		{
			cwd = "~/Documents/Notes",
			actions = {
				["default"] = insert_at_cursor,
			},
		}
	)
end
vim.keymap.set("i", "[[", fzf_obsidian_link, { buffer = true })
vim.keymap.set("n", "<c-p>", "<cmd>ObsidianQuickSwitch<CR>", { buffer = true })

vim.keymap.set("n", "<leader>ta", "<cmd>:TaskWikiAnnotate<CR>")
vim.keymap.set("n", "<leader>tbd", "<cmd>:TaskWikiBurndownDaily<CR>")
vim.keymap.set("n", "<leader>tbw", "<cmd>:TaskWikiBurndownWeekly<CR>")
vim.keymap.set("n", "<leader>tbm", "<cmd>:TaskWikiBurndownMonthly<CR>")
vim.keymap.set("n", "<leader>tcp", "<cmd>:TaskWikiChooseProject<CR>")
vim.keymap.set("n", "<leader>tct", "<cmd>:TaskWikiChooseTag<CR>")
vim.keymap.set("n", "<leader>tC", "<cmd>:TaskWikiCalendar<CR>")
vim.keymap.set("n", "<leader>td", "<cmd>:TaskWikiDone<CR>")
vim.keymap.set("n", "<leader>tD", "<cmd>:TaskWikiDelete<CR>")
vim.keymap.set("n", "<leader>te", "<cmd>:TaskWikiEdit<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd>:TaskWikiGrid<CR>")
vim.keymap.set("n", "<leader>tGm", "<cmd>:TaskWikiGhistoryMonthly<CR>")
vim.keymap.set("n", "<leader>tGa", "<cmd>:TaskWikiGhistoryAnnual<CR>")
vim.keymap.set("n", "<leader>thm", "<cmd>:TaskWikiHistoryMonthly<CR>")
vim.keymap.set("n", "<leader>tha", "<cmd>:TaskWikiHistoryAnnual<CR>")
vim.keymap.set("n", "<leader>ti", "<cmd>:TaskWikiInfo<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>:TaskWikiLink<CR>")
vim.keymap.set("n", "<leader>tm", "<cmd>:TaskWikiMod<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>:TaskWikiProjects<CR>")
vim.keymap.set("n", "<leader>ts", "<cmd>:TaskWikiProjectsSummary<CR>")
vim.keymap.set("n", "<leader>tS", "<cmd>:TaskWikiStats<CR>")
vim.keymap.set("n", "<leader>tt", "<cmd>:TaskWikiTags<CR>")
vim.keymap.set("n", "<leader>t.", "<cmd>:TaskWikiRedo<CR>")
vim.keymap.set("n", "<leader>t+", "<cmd>:TaskWikiStart<CR>")
vim.keymap.set("n", "<leader>t-", "<cmd>:TaskWikiStop<CR>")

vim.keymap.set("v", "<leader>ta", "<cmd>:TaskWikiAnnotate<CR>")
vim.keymap.set("v", "<leader>tcp", "<cmd>:TaskWikiChooseProject<CR>")
vim.keymap.set("v", "<leader>tct", "<cmd>:TaskWikiChooseTag<CR>")
vim.keymap.set("v", "<leader>td", "<cmd>:TaskWikiDone<CR>")
vim.keymap.set("v", "<leader>tD", "<cmd>:TaskWikiDelete<CR>")
vim.keymap.set("v", "<leader>te", "<cmd>:TaskWikiEdit<CR>")
vim.keymap.set("v", "<leader>tg", "<cmd>:TaskWikiGrid<CR>")
vim.keymap.set("v", "<leader>ti", "<cmd>:TaskWikiInfo<CR>")
vim.keymap.set("v", "<leader>tl", "<cmd>:TaskWikiLink<CR>")
vim.keymap.set("v", "<leader>tm", "<cmd>:TaskWikiMod<CR>")
vim.keymap.set("v", "<leader>t.", "<cmd>:TaskWikiRedo<CR>")
vim.keymap.set("v", "<leader>t+", "<cmd>:TaskWikiStart<CR>")
vim.keymap.set("v", "<leader>t-", "<cmd>:TaskWikiStop<CR>")
