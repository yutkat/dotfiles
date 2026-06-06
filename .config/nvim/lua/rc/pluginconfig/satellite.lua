require("satellite").setup({
	current_only = false,
	winblend = 50,
	zindex = 40,
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
	},
	width = 2,
	handlers = {
		cursor = {
			enable = true,
		},
		search = {
			enable = true,
		},
		diagnostic = {
			enable = true,
			signs = { "-", "=", "≡" },
			min_severity = vim.diagnostic.severity.HINT,
		},
		gitsigns = {
			enable = true,
		},
		marks = {
			enable = true,
			show_builtins = false,
		},
		quickfix = {
			enable = true,
		},
	},
})
