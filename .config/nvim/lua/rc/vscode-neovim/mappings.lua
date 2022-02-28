-- https://github.com/asvetliakov/vscode-neovim#normal-mode-control-keys
-- available by default
-- CTRL-a
-- CTRL-b
-- CTRL-c
-- CTRL-d
-- CTRL-e
-- CTRL-f
-- CTRL-i
-- CTRL-o
-- CTRL-r
-- CTRL-u
-- CTRL-v
-- CTRL-w
-- CTRL-x
-- CTRL-y
-- CTRL-]
-- CTRL-j
-- CTRL-k
-- CTRL-l
-- CTRL-h
-- CTRL-/

vim.keymap.set("n", "H", "<Cmd>Tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", "<Cmd>Tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<Leader>p",
	"<<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>>",
	{ noremap = true, silent = true }
)
