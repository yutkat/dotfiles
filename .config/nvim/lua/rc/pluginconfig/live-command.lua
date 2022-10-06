require("live-command").setup({
	commands = {
		Norm = { cmd = "norm" },
	},
	defaults = {
		enable_highlighting = true,
		inline_highlighting = true,
		hl_groups = {
			insertion = "DiffAdd",
			deletion = "DiffDelete",
			change = "DiffChange",
		},
		debug = false,
	},
})
