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
