require("neoclip").setup({
	history = 10000,
	enable_persistent_history = true,
	db_path = vim.fn.stdpath("state") .. "/databases/neoclip.sqlite3",
	filter = nil,
	preview = true,
	default_register = '"',
	content_spec_column = false,
	on_paste = { set_reg = false },
	on_replay = {
		set_reg = false,
	},
	keys = {
		telescope = {
			i = { select = "<cr>", paste = "<c-p>", paste_behind = "<c-k>", replay = "<c-q>", custom = {} },
			n = { select = "<cr>", paste = "mp", paste_behind = "mP", replay = "<c-q>", custom = {} },
		},
	},
})

require("telescope").load_extension("neoclip")
vim.api.nvim_set_keymap("n", "[_FuzzyFinder]p", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
