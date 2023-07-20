local lspsaga = require("lspsaga")
lspsaga.setup({ -- defaults ...
	ui = {
		code_action = "󰌶",
		diagnostic = "",
	},
	lightbulb = {
		virtual_text = false,
	},
	finder = {
		scroll_down = "<C-f>",
		scroll_up = "<C-b>", -- quit can be a table
		quit = { "q", "<ESC>" },
	},
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
})

vim.keymap.set("n", "[_Lsp]r", "<cmd>Lspsaga rename ++project<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "M", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
vim.keymap.set("x", "M", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "?", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]j", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]k", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]s", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]d", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "[_Lsp]l", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]c", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]b", "<cmd>Lspsaga show_buf_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[E", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })
vim.keymap.set("n", "]E", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]I", "<cmd>Lspsaga incoming_calls<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[_Lsp]O", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true, noremap = true })
