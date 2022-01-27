require("nvim-comment-frame").setup({
	-- if true, <leader>cf keymap will be disabled
	disable_default_keymap = false,
	-- adds custom keymap
	keymap = "<leader>cc",
	multiline_keymap = "<leader>C",
	-- start the comment with this string
	start_str = "//",
	-- end the comment line with this string
	end_str = "//",
	-- fill the comment frame border with this character
	fill_char = "-",
	-- width of the comment frame
	frame_width = 70,
	-- wrap the line after 'n' characters
	line_wrap_len = 50,
	-- automatically indent the comment frame based on the line
	auto_indent = true,
	-- add comment above the current line
	add_comment_above = true,
	-- configurations for individual language goes here
	languages = {},
})
