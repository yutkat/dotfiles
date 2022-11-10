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
		map({ "n", "v" }, "[_Git]hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "[_Git]hr", ":Gitsigns reset_hunk<CR>")
		map("n", "[_Git]hS", gs.stage_buffer)
		map("n", "[_Git]hu", gs.undo_stage_hunk)
		map("n", "[_Git]hR", gs.reset_buffer)
		map("n", "[_Git]hp", gs.preview_hunk)
		map("n", "[_Git]b", function()
			gs.blame_line({ full = true })
		end)
		map("n", "[_Git]tb", gs.toggle_current_line_blame)
		-- diffview
		-- map("n", "Ghd", gs.diffthis)
		-- map("n", "GhD", function()
		-- 	gs.diffthis("~")
		-- end)
		map("n", "[_Git]td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
