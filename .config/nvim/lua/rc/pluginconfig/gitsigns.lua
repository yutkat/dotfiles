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
		map({ "n", "v" }, "Ghs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "Ghr", ":Gitsigns reset_hunk<CR>")
		map("n", "GhS", gs.stage_buffer)
		map("n", "Ghu", gs.undo_stage_hunk)
		map("n", "GhR", gs.reset_buffer)
		map("n", "Ghp", gs.preview_hunk)
		map("n", "Ghb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "Gtb", gs.toggle_current_line_blame)
		map("n", "Ghd", gs.diffthis)
		map("n", "GhD", function()
			gs.diffthis("~")
		end)
		map("n", "Gtd", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
