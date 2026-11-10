require("tree-sitter-manager").setup({
	parser_dir = vim.fn.stdpath("data") .. "/site/parser",
	query_dir = vim.fn.stdpath("data") .. "/site/queries",
})
