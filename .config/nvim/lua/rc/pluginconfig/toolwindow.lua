vim.keymap.set("n", "[_Lsp]bc", "<Cmd>lua require('toolwindow').close()<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"n",
	"[_Lsp]bt",
	"<Cmd>lua require('toolwindow').open_window('quickfix', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[_Lsp]bt",
	"<Cmd>lua require('toolwindow').open_window('term', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[_Lsp]bd",
	"<Cmd>lua require('toolwindow').open_window('trouble', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[_Lsp]bn",
	"<Cmd>lua require('toolwindow').open_window('todo', nil)<CR>",
	{ noremap = true, silent = true }
)
