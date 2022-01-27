require("goto-preview").setup({})
vim.keymap.set(
	"n",
	"gpd",
	"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"gpi",
	"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"n",
	"gpr",
	"<cmd>lua require('goto-preview').goto_preview_references()<CR>",
	{ noremap = true, silent = true }
)
