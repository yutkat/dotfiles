require("nvim-surround").setup({
	move_cursor = false,
	keymaps = { -- vim-surround style keymaps
		insert = "<C-s>",
		insert_line = "<C-s><C-s>",
		normal = "sa",
		normal_line = "saa",
		normal_cur_line = "sS",
		visual = "s",
		delete = "sd",
		change = "sr",
	},
	aliases = {
		["a"] = "a",
		["b"] = "b",
		["B"] = "B",
		["r"] = "r",
		["q"] = { '"', "'", "`" }, -- Any quote character
		[";"] = { ")", "]", "}", ">", "'", '"', "`" }, -- Any surrounding delimiter
	},
	highlight = { -- Highlight before inserting/changing surrounds
		duration = 0,
	},
})

-- vim.keymap.set("o", ";", function()
-- 	local current_operator = vim.v.operator
-- 	local utils = require("nvim-surround.utils")
-- 	local sel = utils.get_nearest_selections(";")
-- 	if sel == nil or sel.left == nil then
-- 		return
-- 	end
-- 	local char = vim.api.nvim_buf_get_text(
-- 		0,
-- 		sel.left.first_pos[1] - 1,
-- 		sel.left.first_pos[2] - 1,
-- 		sel.left.first_pos[1] - 1,
-- 		sel.left.first_pos[2],
-- 		{}
-- 	)
-- 	vim.cmd(current_operator .. "i" .. char[1])
-- end, { noremap = false, expr = false, silent = true })
