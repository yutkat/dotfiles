require("edgy").setup({
	animate = { enabled = false },
	left = {
		-- snacks explorer (opened with `gx`)
		{
			title = "Explorer",
			ft = "snacks_layout_box",
			size = { width = 30 },
			filter = function(_buf, win)
				return vim.w[win].snacks_win
					and vim.w[win].snacks_win.position == "left"
					and vim.w[win].snacks_win.relative == "editor"
					and not vim.w[win].trouble_preview
			end,
			open = function()
				require("snacks").explorer()
			end,
		},
	},
	bottom = {
		-- snacks terminal (toggled with <C-z>)
		{
			ft = "snacks_terminal",
			title = "%{b:snacks_terminal.id}: %{b:term_title}",
			size = { height = 0.4 },
			filter = function(_buf, win)
				return vim.w[win].snacks_win
					and vim.w[win].snacks_win.position == "bottom"
					and vim.w[win].snacks_win.relative == "editor"
					and not vim.w[win].trouble_preview
			end,
		},
		{ ft = "qf", title = "QuickFix" },
	},
})
