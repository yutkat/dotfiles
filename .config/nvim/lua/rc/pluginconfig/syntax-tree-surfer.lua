---- Normal Mode Swapping
--vim.api.nvim_set_keymap("n", "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', {noremap = true, silent = true})
---- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
--vim.api.nvim_set_keymap("n", "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', {noremap = true, silent = true})
---- .select_current_node() will select the current node at your cursor
--vim.api.nvim_set_keymap("n", "vn", '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', {noremap = true, silent = true})

-- NAVIGATION: Only change the keymap to your liking. I would not recommend changing anything about the .surf() parameters!
-- vim.api.nvim_set_keymap(
-- 	"x",
-- 	"J",
-- 	'<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>',
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"x",
-- 	"K",
-- 	'<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>',
-- 	{ noremap = true, silent = true }
-- )
vim.api.nvim_set_keymap(
	"x",
	"v",
	'<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"x",
	"V",
	'<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>',
	{ noremap = true, silent = true }
)

-- SWAPPING WITH VISUAL SELECTION: Only change the keymap to your liking. Don't change the .surf() parameters!
--vim.api.nvim_set_keymap("x", "<A-j>", '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap("x", "<A-k>", '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>', {noremap = true, silent = true})
