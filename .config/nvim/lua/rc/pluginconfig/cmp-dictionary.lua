local dict = require("cmp_dictionary")
dict.setup({
	paths = { vim.fn.stdpath("data") .. "/../zsh/dictionary/my.dict" },
	exact_length = 2,
	first_case_insensitive = false,
	document = {
		enable = true,
		command = { "wn", "${label}", "-over" },
	},
})
