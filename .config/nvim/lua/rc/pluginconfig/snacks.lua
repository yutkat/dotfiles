local function in_git_repo()
	return require("snacks").git.get_root() ~= nil
end

require("snacks").setup({
	animate = { fps = 240 },
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			-- Lazy defaults to a supplementary-plane icon that WezTerm renders wider than Neovim assumes
			-- stylua: ignore
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				-- Review AI changes (stage your own work first so diffs show only the AI edits)
				{ icon = " ", key = "d", desc = "Review Changes", action = ":lua Snacks.dashboard.pick('git_diff')", enabled = in_git_repo },
				{ icon = " ", key = "l", desc = "Git Log", action = ":lua Snacks.dashboard.pick('git_log')", enabled = in_git_repo },
				{ icon = " ", key = "G", desc = "Neogit", action = ":Neogit", enabled = in_git_repo },
				{ icon = " ", key = "a", desc = "Claude", action = function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end },
				{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
				{ icon = " ", key = "s", desc = "Restore Session", action = ":SessionLoadCurrent" }, -- session for cwd (mini-sessions.lua)
				{ icon = " ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
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
	-- "mark" shows a-zA-Z mark signs (replaces chentoast/marks.nvim)
	statuscolumn = { enabled = true, left = { "mark", "sign" } },
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
