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
				gs.nav_hunk("next")
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.nav_hunk("prev")
			end)
			return "<Ignore>"
		end, { expr = true })

		-- ]c/[c skip staged hunks (staged = reviewed); ]C/[C include them
		map("n", "]C", function()
			gs.nav_hunk("next", { target = "all" })
		end, { desc = "Next hunk (staged and unstaged)" })
		map("n", "[C", function()
			gs.nav_hunk("prev", { target = "all" })
		end, { desc = "Prev hunk (staged and unstaged)" })

		-- Actions
		map({ "n", "v" }, "[_Git]hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "[_Git]hr", ":Gitsigns reset_hunk<CR>")
		map("n", "[_Git]hS", gs.stage_buffer)
		map("n", "[_Git]hu", gs.stage_hunk)
		map("n", "[_Git]hR", gs.reset_buffer)
		map("n", "[_Git]hp", gs.preview_hunk)
		map("n", "[_Git]b", function()
			gs.blame_line({ full = true })
		end)
		map("n", "[_Git]tb", gs.toggle_current_line_blame)
		-- Diff views (replace mini.diff): inline toggle, or side-by-side in a new tab (:tabclose to leave)
		map("n", "[_Git]d", function()
			gs.diffthis(nil, { unified = true })
		end, { desc = "Toggle inline diff (buffer)" })
		map("n", "[_Git]hd", function()
			vim.cmd("tab split")
			gs.diffthis()
		end, { desc = "Diff against index in a new tab" })
		map("n", "[_Git]hD", function()
			vim.cmd("tab split")
			gs.diffthis("HEAD")
		end, { desc = "Diff against HEAD in a new tab" })
		map("n", "[_Git]td", gs.preview_hunk_inline)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
