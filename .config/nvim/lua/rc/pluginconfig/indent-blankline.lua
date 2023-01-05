vim.g.indent_blankline_enabled = false

require("indent_blankline").setup({
	show_current_context = false,
	use_treesitter = true,
	buftype_exclude = { "terminal" },
	filetype_exclude = {
		"help",
		"dashboard",
		"dashpreview",
		"NvimTree",
		"neo-tree",
		"vista",
		"sagahover",
		"sagasignature",
		"packer",
		"lazy",
		"log",
		"lspsagafinder",
		"lspinfo",
		"dapui_scopes",
		"dapui_breakpoints",
		"dapui_stacks",
		"dapui_watches",
		"dap-repl",
		"toggleterm",
		"alpha",
		"coc-explorer",
	},
	-- char_highlight_list = {
	--   "IndentBlanklineIndent1", "IndentBlanklineIndent1", "IndentBlanklineIndent1",
	--   "IndentBlanklineIndent1", "IndentBlanklineIndent1", "IndentBlanklineIndent1",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar", "IndentBlanklineChar",
	--   "IndentBlanklineChar", "IndentBlanklineChar"
	-- }
})

-- vim.api.nvim_clear_autocmds({ event = { "TextChanged", "TextChangedI" }, group = "IndentBlanklineAutogroup" })
