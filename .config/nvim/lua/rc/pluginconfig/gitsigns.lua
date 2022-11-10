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
		map({ "n", "v" }, "[Git]hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "[Git]hr", ":Gitsigns reset_hunk<CR>")
		map("n", "[Git]hS", gs.stage_buffer)
		map("n", "[Git]hu", gs.undo_stage_hunk)
		map("n", "[Git]hR", gs.reset_buffer)
		map("n", "[Git]hp", gs.preview_hunk)
		map("n", "[Git]b", function()
			gs.blame_line({ full = true })
		end)
		map("n", "[Git]tb", gs.toggle_current_line_blame)
		-- diffview
		-- map("n", "Ghd", gs.diffthis)
		-- map("n", "GhD", function()
		-- 	gs.diffthis("~")
		-- end)
		map("n", "[Git]td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
