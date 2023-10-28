-- require('indent_guides').default_opts = {
--   indent_levels = 30;
--   indent_guide_size = 0;
--   indent_start_level = 1;
--   indent_space_guides = true;
--   indent_tab_guides = true;
--   indent_pretty_guides = true;
--   indent_soft_pattern = '\\s';
--   exclude_filetypes = {'help'}
-- }
-- vim.cmd('IndentGuidesDisable')
-- require('indent_guides').indent_guides_disable()
require("indent_guides").setup({
	indent_start_level = 6,
	exclude_filetypes = {
		"help",
		"dashboard",
		"dashpreview",
		"NvimTree",
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
		"checkhealth",
		"man",
		"gitcommit",
		"TelescopePrompt",
		"TelescopeResults",
		""
	},
})
