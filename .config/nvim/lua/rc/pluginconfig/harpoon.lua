require("harpoon").setup({
	global_settings = { save_on_toggle = false, save_on_change = true, enter_on_sendcmd = false },
	menu = { width = 50, height = 8, borderchars = { "", "", "", "", "", "", "", "" } },
})

vim.api.nvim_set_keymap("n", "[_Mark]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "'", "[_Mark]", {})
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]'",
	'<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]a",
	'<Cmd>lua require("harpoon.mark").add_file()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]1",
	'<Cmd>lua require("harpoon.ui").nav_file(1)<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]2",
	'<Cmd>lua require("harpoon.ui").nav_file(2)<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]3",
	'<Cmd>lua require("harpoon.ui").nav_file(3)<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]4",
	'<Cmd>lua require("harpoon.ui").nav_file(4)<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Mark]5",
	'<Cmd>lua require("harpoon.ui").nav_file(5)<CR>',
	{ noremap = true, silent = true }
)
vim.cmd([[
highlight HarpoonBorder guibg=#282828 guifg=white
highlight HarpoonWindow guibg=#282828 guifg=white
augroup vimrc_harpoon
	autocmd!
	autocmd Filetype harpoon nnoremap <buffer><silent> <Esc> <Cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
augroup END
]])
