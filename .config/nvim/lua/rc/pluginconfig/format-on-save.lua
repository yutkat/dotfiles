local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
	experiments = {
		partial_update = 'diff',
	},
	exclude_path_patterns = {
		"/node_modules/",
	},
	formatter_by_ft = {
		css = formatters.lsp,
		html = formatters.lsp,
		java = formatters.lsp,
		javascript = formatters.lsp,
		json = formatters.lsp,
		lua = formatters.lsp,
		markdown = { formatters.prettierd,
			formatters.shell({
				cmd = { "markdown-toc", "-i", "%" },
				tempfile = function()
					return vim.fn.expand("%") .. '.markdown-toc-temp'
				end
			}) },
		openscad = formatters.lsp,
		python = formatters.black,
		rust = formatters.lsp,
		scad = formatters.lsp,
		scss = formatters.lsp,
		sh = formatters.shfmt,
		terraform = formatters.lsp,
		typescript = formatters.prettierd,
		typescriptreact = formatters.prettierd,
		yaml = formatters.lsp,
	},
	fallback_formatter = {
		formatters.remove_trailing_whitespace,
	}
})
