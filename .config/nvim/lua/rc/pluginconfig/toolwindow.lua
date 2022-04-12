vim.keymap.set("n", "[lsp]bc", "<Cmd>lua require('toolwindow').close()<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"n",
	"[lsp]bt",
	"<Cmd>lua require('toolwindow').open_window('quickfix', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[lsp]bt",
	"<Cmd>lua require('toolwindow').open_window('term', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[lsp]bd",
	"<Cmd>lua require('toolwindow').open_window('trouble', nil)<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"[lsp]bn",
	"<Cmd>lua require('toolwindow').open_window('todo', nil)<CR>",
	{ noremap = true, silent = true }
)
