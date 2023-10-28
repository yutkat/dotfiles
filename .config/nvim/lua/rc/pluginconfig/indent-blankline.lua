local highlight = {
	"IblNonIndent",
	"IblNonIndent",
	"IblNonIndent",
	"IblNonIndent",
	"IblNonIndent",
	"IblNonIndent",
	"IblIndent",
	"IblIndent",
	"IblIndent",
	"IblIndent",
}
local hooks = require "ibl.hooks"
local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "IblNonIndent", { fg = normal_hl.bg })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = "#444c5e" })
end)

require("ibl").overwrite({
	indent = { highlight = highlight },
	whitespace = {
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
	exclude = {
		buftypes = {
			"terminal",
			"nofile",
			"quickfix",
			"prompt",
		},
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
			"mason",
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
			"checkhealth",
			"man",
			"gitcommit",
			"TelescopePrompt",
			"TelescopeResults",
		},
	}
})
