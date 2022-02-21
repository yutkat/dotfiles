local neogit = require("neogit")
neogit.setup({
	integrations = { diffview = true },
	sections = {
		stashes = {
			folded = false,
		},
		recent = { folded = false },
	},
})

vim.api.nvim_set_keymap("n", "<git><Space>", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<git>s", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<git>s", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
