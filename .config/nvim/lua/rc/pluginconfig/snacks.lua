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
	explorer = { enabled = true, eplace_netrw = true, hidden = false },
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
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

vim.keymap.set("n", "<C-x>",
	function() require('snacks').bufdelete({ wipe = true }) end,
	{ noremap = true, silent = true })
vim.keymap.set("n", "gx",
	function() require("snacks").explorer({ hidden = true }) end,
	{ noremap = true, silent = true })
vim.keymap.set({ "n", "t", "i" }, "<C-z>",
	function()
		require("snacks").terminal.toggle(vim.o.shell)
	end,
	{ noremap = true, silent = true, desc = "Toggle terminal" })
--- https://github.com/neovim/neovim/issues/14061
vim.cmd [[cnoreabbrev wqa wa\|qa]]
