local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga({ -- defaults ...
	-- Options with default value
	-- "single" | "double" | "rounded" | "bold" | "plus"
	border_style = "single",
	--the range of 0 for fully opaque window (disabled) to 100 for fully
	--transparent background. Values between 0-30 are typically most useful.
	saga_winblend = 0,
	-- when cursor in saga window you config these to move
	move_in_saga = { prev = "<C-p>", next = "<C-n>" },
	-- Error, Warn, Info, Hint
	-- use emoji like
	-- { "🙀", "😿", "😾", "😺" }
	-- or
	-- { "😡", "😥", "😤", "😐" }
	-- and diagnostic_header can be a function type
	-- must return a string and when diagnostic_header
	-- is function type it will have a param `entry`
	-- entry is a table type has these filed
	-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
	diagnostic_header = { " ", " ", " ", "ﴞ " },
	-- show diagnostic source
	show_diagnostic_source = true,
	-- add bracket or something with diagnostic source, just have 2 elements
	diagnostic_source_bracket = {},
	-- preview lines of lsp_finder and definition preview
	max_preview_lines = 10,
	-- use emoji lightbulb in default
	code_action_icon = " ",
	-- if true can press number to execute the codeaction in codeaction window
	code_action_num_shortcut = true,
	-- same as nvim-lightbulb but async
	code_action_lightbulb = {
		enable = true,
		sign = true,
		sign_priority = 20,
		virtual_text = true,
	},
	-- finder icons
	finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	},
	-- custom finder title winbar function type
	-- param is current word with symbol icon string type
	-- return a winbar format string like `%#CustomFinder#Test%*`
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		tabe = "t",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>", -- quit can be a table
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_quit = "<C-c>",
	definition_preview_icon = "  ",
	-- show symbols in winbar must nightly
	symbol_in_winbar = {
		in_custom = false,
		enable = false,
		separator = " ",
		show_file = true,
		click_support = false,
	},
	-- show outline
	show_outline = {
		win_position = "right",
		-- set the special filetype in there which in left like nvimtree neotree defx
		left_with = "",
		win_width = 30,
		auto_enter = true,
		auto_preview = true,
		virt_text = "┃",
		jump_key = "o",
		-- auto refresh when change buffer
		auto_refresh = true,
	},
})

vim.keymap.set("n", "[lsp]r", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "M", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
vim.keymap.set("x", "M", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "?", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]o", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]j", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]k", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]s", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[lsp]d", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
vim.keymap.set("n", "[lsp]o", "<cmd>LSoutlineToggle<CR>", { silent = true })
vim.keymap.set(
	"n",
	"<C-b>",
	"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set(
	"n",
	"<C-f>",
	"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",
	{ silent = true, noremap = true }
)
