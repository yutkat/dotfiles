require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "[git]hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "[git]hr", ":Gitsigns reset_hunk<CR>")
		map("n", "[git]hS", gs.stage_buffer)
		map("n", "[git]hu", gs.undo_stage_hunk)
		map("n", "[git]hR", gs.reset_buffer)
		map("n", "[git]hp", gs.preview_hunk)
		map("n", "[git]b", function()
			gs.blame_line({ full = true })
		end)
		map("n", "[git]tb", gs.toggle_current_line_blame)
		-- diffview
		-- map("n", "Ghd", gs.diffthis)
		-- map("n", "GhD", function()
		-- 	gs.diffthis("~")
		-- end)
		map("n", "[git]td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
