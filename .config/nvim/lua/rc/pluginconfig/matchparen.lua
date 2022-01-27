vim.g.loaded_matchparen = 1

require("matchparen").setup({
	on_startup = true, -- Should it be enabled by default
	timeout = 150, -- timeout in ms to drop searching for matched character in normal mode
	timeout_insert = 50, -- same but in insert mode
	hl_group = "MatchParen", -- highlight group for matched characters
	augroup_name = "matchparen", -- almost no reason to touch this if you don't already have augroup with this name
	-- list of neovim default syntax names to skip highlighting
	syn_skip_names = { "string", "comment", "character", "singlequoute", "escape", "symbol" },
	-- list of TreeSitter capture names to skip highlighting
	ts_skip_captures = { "string", "comment" },
})
