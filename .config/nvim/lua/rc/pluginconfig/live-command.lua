require("live-command").setup({
	commands = {
		Norm = { cmd = "norm" },
	},
	enable_highlighting = true,
	inline_highlighting = true,
	hl_groups = {
		insertion = "DiffAdd",
		deletion = "DiffDelete",
		change = "DiffChange",
	},
})
