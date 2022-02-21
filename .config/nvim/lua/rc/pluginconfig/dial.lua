local augend = require("dial.augend")
require("dial.config").augends:register_group({
	-- default augends used when no group name is specified
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.constant.alias.bool, -- boolean value (true <-> false)
	},
})

vim.api.nvim_set_keymap("n", "+", require("dial.map").inc_normal(), { silent = true })
vim.api.nvim_set_keymap("n", "_", require("dial.map").dec_normal(), { silent = true })
vim.api.nvim_set_keymap("v", "+", require("dial.map").inc_visual(), { silent = true })
vim.api.nvim_set_keymap("v", "_", require("dial.map").dec_visual(), { silent = true })
vim.api.nvim_set_keymap("v", "g+", require("dial.map").inc_gvisual(), { silent = true })
vim.api.nvim_set_keymap("v", "g_", require("dial.map").dec_gvisual(), { silent = true })
