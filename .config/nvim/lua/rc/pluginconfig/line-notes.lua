require("line-notes").setup({
	path = vim.fn.stdpath("state") .. "/line-notes.json", -- path where to save the file
	border_chars = {
		top_left = "╭",
		top_mid = "─",
		top_right = "╮",
		mid = "│",
		bottom_left = "╰",
		bottom_right = "╯",
	},
	preview_max_width = 80, -- maximum width of preview notes float window
	auto_preview = false,
	icon = "",
	mappings = { -- pass in false to disable all. Pass in table to override. Partial overrides are possible
		add = "<Leader>lna", -- pass null to disable the mapping
		edit = "<Leader>lne",
		preview = "<Leader>lnp",
		delete = "<Leader>lnd",
	},
})
