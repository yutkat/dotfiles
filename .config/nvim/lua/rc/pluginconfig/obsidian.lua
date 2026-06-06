local home = vim.fn.expand("~/Documents/zettelkasten")

require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{ name = "zettelkasten", path = home },
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
	completion = {
		nvim_cmp = false,
		blink = true,
		min_chars = 2,
	},
	picker = {
		name = "snacks.picker",
	},
	sort_by = "modified",
	sort_reversed = true,
	-- Disable concealing UI to avoid conflicts and keep it lightweight.
	ui = { enable = false },
})

-- Memo keymaps (telekasten had none active; these mirror the old dashboard intents)
vim.keymap.set("n", "<leader>zn", "<cmd>Obsidian new<cr>", { desc = "Obsidian: new note" })
vim.keymap.set("n", "<leader>zt", "<cmd>Obsidian today<cr>", { desc = "Obsidian: today (daily)" })
vim.keymap.set("n", "<leader>zf", "<cmd>Obsidian search<cr>", { desc = "Obsidian: grep notes" })
vim.keymap.set("n", "<leader>zz", "<cmd>Obsidian quick_switch<cr>", { desc = "Obsidian: quick switch" })
vim.keymap.set("n", "<leader>zb", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian: backlinks" })
vim.keymap.set("n", "<leader>zd", "<cmd>Obsidian dailies<cr>", { desc = "Obsidian: daily notes" })
