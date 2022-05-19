local neogit = require("neogit")
neogit.setup({
	disable_commit_confirmation = true,
	integrations = { diffview = true },
	sections = {
		stashes = {
			folded = false,
		},
		recent = { folded = false },
	},
})

vim.api.nvim_set_keymap("n", "[git]<Space>", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[git]s", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[git]S", "<Cmd>Neogit<CR>", { noremap = true, silent = true })

vim.api.nvim_create_augroup("vimrc_neogit", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "vimrc_neogit",
	pattern = { "NeogitCommitMessage" },
	callback = function()
		vim.cmd([[startinsert]])
	end,
	once = false,
})
