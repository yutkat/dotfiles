require("Comment").setup({
	---Add a space b/w comment and the line
	---@type boolean
	padding = true,

	---Line which should be ignored while comment/uncomment
	---Example: Use '^$' to ignore empty lines
	---@type string Lua regex
	ignore = nil,

	---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
	---@type table
	mappings = {
		---operator-pending mapping
		---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
		basic = true,
		---extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extra = false,
	},

	---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
	---@type table
	toggler = {
		---line-comment toggle
		line = "gcc",
		---block-comment toggle
		block = "gbc",
	},

	---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
	---@type table
	opleader = {
		---line-comment opfunc mapping
		line = "gc",
		---block-comment opfunc mapping
		block = "gb",
	},

	---Pre-hook, called before commenting the line
	---@type function|nil
	pre_hook = function()
		return require("ts_context_commentstring.internal").calculate_commentstring()
	end,
	---Post-hook, called after commenting is done
	---@type function|nil
	post_hook = nil,
})

vim.api.nvim_set_keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
vim.api.nvim_set_keymap("i", "<C-_>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
vim.api.nvim_set_keymap("n", "<C-/>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
vim.api.nvim_set_keymap("v", "<C-/>", "gc", {})
