local vault = vim.fn.expand("~/Documents/obsidian")
vim.fn.mkdir(vault, "p")

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{ name = "obsidian", path = vault },
	},
	new_notes_location = "current_dir",
	notes_subdir = "",
	daily_notes = {
		folder = "daily",
		date_format = "%Y-%m-%d",
		template = "daily.md",
	},
	templates = {
		folder = vim.fn.stdpath("config") .. "/zettelkasten/templates",
	},
	picker = {
		name = "snacks.picker",
	},
	-- Disable concealing UI to avoid conflicts and keep it lightweight.
	ui = { enable = false },
})
