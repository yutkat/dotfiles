require("snacks").setup({
	animate = { fps = 240 },
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
			{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{ section = "startup" },
		},
	},
	explorer = { enabled = true, replace_netrw = true, hidden = false },
	indent = {
		enabled = true,
		only_scope = true,
		only_current = true,
	},
	input = {
		enabled = true,
	},
	picker = {
		enabled = true,
		ui_select = true, -- replace vim.ui.select (was telescope-ui-select)
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

vim.keymap.set("n", "<C-x>", function()
	require("snacks").bufdelete({ wipe = true })
end, { noremap = true, silent = true })
vim.keymap.set("n", "gx", function()
	require("snacks").explorer({ hidden = true })
end, { noremap = true, silent = true })
vim.keymap.set({ "n", "t", "i" }, "<C-z>", function()
	-- floating terminal (not docked by edgy; edgy only manages editor-relative windows)
	require("snacks").terminal.toggle(vim.o.shell, { win = { position = "float" } })
end, { noremap = true, silent = true, desc = "Toggle terminal" })

-- bottom (editor-relative) terminal, docked by edgy.nvim
vim.api.nvim_create_user_command("Terminal", function()
	require("snacks").terminal.toggle(vim.o.shell, { win = { position = "bottom" } })
end, { desc = "Toggle bottom terminal (docked by edgy)" })

-- snacks owns vim.notify, so notifications (incl. lazy.nvim errors) land in its
-- history, not Noice. Quick access to that history.
vim.api.nvim_create_user_command("Notifications", function()
	require("snacks").notifier.show_history()
end, { desc = "Show notification history (snacks)" })
--- https://github.com/neovim/neovim/issues/14061
vim.cmd([[cnoreabbrev wqa wa\|qa]])

-- Fuzzy finder keymaps (migrated from telescope)
require("rc/pluginconfig/snacks-picker")
