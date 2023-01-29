local modicator = require("modicator")
vim.o.cursorline = true
modicator.setup({
	show_warnings = false,
	line_numbers = false,
	cursorline = true,
	highlights = {
		modes = {
			["n"] = {
				foreground = modicator.get_highlight_fg("CursorLineNr"),
			},
			["i"] = {
				foreground = modicator.get_highlight_bg("lualine_a_insert"),
			},
			["v"] = {
				foreground = modicator.get_highlight_bg("lualine_a_visual"),
			},
			["V"] = {
				foreground = modicator.get_highlight_bg("lualine_a_visual"),
			},
			["�"] = { -- This symbol is the ^V character
				foreground = modicator.get_highlight_bg("lualine_a_visual"),
			},
			["s"] = {
				foreground = modicator.get_highlight_bg("lualine_a_inactive"),
			},
			["S"] = {
				foreground = modicator.get_highlight_bg("lualine_a_inactive"),
			},
			["R"] = {
				foreground = modicator.get_highlight_bg("lualine_a_replace"),
			},
			["c"] = {
				foreground = modicator.get_highlight_bg("lualine_a_command"),
			},
		},
	},
})
