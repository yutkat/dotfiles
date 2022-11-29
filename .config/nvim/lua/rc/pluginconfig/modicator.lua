local modicator = require("modicator")
vim.o.cursorline = true
modicator.setup({
	line_numbers = false,
	cursorline = true,
	highlights = {
		modes = {
			["i"] = "#81b29a",
			["v"] = "#9d79d6",
			["V"] = "#9d79d6",
			[""] = "#9d79d6",
			["s"] = "#dbc074",
			["S"] = "#dbc074",
			["R"] = "#c94f6d",
			["c"] = "#719cd6",
		},
	},
})
