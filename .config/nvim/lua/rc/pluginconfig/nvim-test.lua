require("nvim-test").setup({
	termOpts = {
		direction = "horizontal", -- terminal's direction ("horizontal"|"vertical"|"float")
		height = 30, -- terminal's height (for horizontal|float)
		go_back = false,
	},
})

vim.keymap.set("n", "[_Make]n", "<Cmd>TestSuite<CR><C-w><C-p>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Make]l", "<Cmd>TestLast<CR><C-w><C-p>", { noremap = true, silent = true })
