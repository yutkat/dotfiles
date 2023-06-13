vim.cmd.highlight("TabLineSel guibg=#ddc7a1")

require("bufferline").setup({
	options = {
		numbers = function(opts)
			return string.format("%s.%s", opts.ordinal, opts.lower(opts.id))
		end,
		-- numbers = "both",
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		-- indicator_icon = '▎',
		-- buffer_close_icon = '',
		-- modified_icon = '●',
		-- close_icon = '',
		-- left_trunc_marker = '',
		-- right_trunc_marker = '',
		-- max_name_length = 18,
		-- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		-- tab_size = 18,
		-- diagnostics = false,
		diagnostics = "nvim_lsp",

		-- selene: allow(unused_variable)
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype == "qf" then
				return false
			end
			if vim.bo[buf_number].buftype == "terminal" then
				return false
			end
			-- -- filter out by buffer name
			if vim.api.nvim_buf_get_name(buf_number) == "" or vim.api.nvim_buf_get_name(buf_number) == "[No Name]" then
				return false
			end
			if vim.api.nvim_buf_get_name(buf_number) == "[dap-repl]" then
				return false
			end
			-- -- filter out based on arbitrary rules
			-- -- e.g. filter out vim wiki buffer from tabline in your work repo
			-- if vim.uv.cwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
			--   return true
			-- end
			return true
		end,
		-- offsets = {
		--   {filetype = "NvimTree", text = "File Explorer", text_align = "left" | "center" | "right"}
		-- },
		-- show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		-- show_tab_indicators = true
		-- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		-- separator_style = "thick",
		enforce_regular_tabs = true,
		-- always_show_bufferline = true
		-- sort_by = "insert_after_current",
		-- sort_by = 'relative_directory'
		sort_by = function(buffer_a, buffer_b)
			if not buffer_a and buffer_b then
				return true
			elseif buffer_a and not buffer_b then
				return false
			end
			return buffer_a.ordinal < buffer_b.ordinal
		end,
	},
})
vim.keymap.set("n", "<Leader>b", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "@", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "#", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-h>", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-l>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-F2>", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-F3>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>1", function()
	require("bufferline").go_to_buffer(1, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>2", function()
	require("bufferline").go_to_buffer(2, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>3", function()
	require("bufferline").go_to_buffer(3, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>4", function()
	require("bufferline").go_to_buffer(4, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>5", function()
	require("bufferline").go_to_buffer(5, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>6", function()
	require("bufferline").go_to_buffer(6, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>7", function()
	require("bufferline").go_to_buffer(7, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>8", function()
	require("bufferline").go_to_buffer(8, true)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>9", function()
	require("bufferline").go_to_buffer(9, true)
end, { noremap = true, silent = true })
