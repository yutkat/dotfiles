local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	opts
)

if require("rc/packer").is_plugin_installed("vim-asterisk") then
	vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
	vim.api.nvim_set_keymap("n", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})

	vim.api.nvim_set_keymap("x", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
	vim.api.nvim_set_keymap("x", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
else
	vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
end
