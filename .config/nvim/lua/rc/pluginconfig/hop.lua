require("hop").setup({})

vim.api.nvim_set_keymap(
	"n",
	"SS",
	"<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",
	{}
)
vim.api.nvim_set_keymap(
	"n",
	"Ss",
	"<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",
	{}
)
vim.api.nvim_set_keymap(
	"x",
	"SS",
	"<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<CR>",
	{}
)
vim.api.nvim_set_keymap(
	"x",
	"Ss",
	"<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<CR>",
	{}
)
