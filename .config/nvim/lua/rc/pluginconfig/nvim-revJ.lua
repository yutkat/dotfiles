require("revj").setup({
	brackets = { first = "([{<", last = ")]}>" }, -- brackets to consider surrounding arguments
	new_line_before_last_bracket = true, -- add new line between last argument and last bracket (only if no last seperator)
	add_seperator_for_last_parameter = true, -- if a seperator should be added if not present after last parameter
	enable_default_keymaps = false, -- enables default keymaps without having to set them below
	keymaps = {
		operator = "Q", -- for operator (+motion)
		line = "<Leader>Q", -- for formatting current line
		visual = "Q", -- for formatting visual selection
	},
	parameter_mapping = ",", -- specifies what text object selects an arguments (ie a, and i, by default)
	-- if you're using `vim-textobj-parameter` you can also set this to `vim.g.vim_textobj_parameter_mapping`
})
