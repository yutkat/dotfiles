vim.g.indent_blankline_enabled = false

require("ibl").overwrite({
	exclude = {
		buftypes = { "terminal" },
		filetypes = {
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
	}
})
