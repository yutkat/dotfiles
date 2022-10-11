local modicator = require("modicator")
modicator.setup({
	line_numbers = true,
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
