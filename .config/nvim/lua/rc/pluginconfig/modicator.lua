local modicator = require("modicator")
vim.o.cursorline = true
modicator.setup({
	show_warnings = false,
	line_numbers = false,
	cursorline = true,
	integration = {
		lualine = {
			enabled = true,
		},
	},
})
