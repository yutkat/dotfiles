-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function ts_disable(_, bufnr)
	return vim.api.nvim_buf_line_count(bufnr) > 5000
end

require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of 'all', 'language', or a list of languages
	highlight = {
		enable = true,         -- false will disable the whole extension
		disable = {},          -- list of language that will be disabled
		-- disable = function(lang, bufnr)
		-- 		return lang == "cmake" or ts_disable(lang, bufnr)
		-- end,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = { -- mappings for incremental selection (visual mappings)
			-- node_incremental = "grn", -- increment to the upper named parent
			-- scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
			-- init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
			-- node_decremental = "grm" -- decrement to the previous node
			-- init_selection = "<CR>",
			-- scope_incremental = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<S-CR>",
		},
	},
	indent = { enable = false, disable = { "python" } },
	refactor = {
		highlight_definitions = { enable = false },
		highlight_current_scope = { enable = false },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "'r", -- mapping to rename reference under cursor
			},
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "'d", -- mapping to go to definition of symbol under cursor
				list_definitions = "'D", -- mapping to list all definitions in current file
			},
		},
	},
	textobjects = { -- syntax-aware textobjects
		select = {
			enable = true,
			disable = {},
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["iB"] = "@block.inner",
				["aB"] = "@block.outer",
				-- use sandwich
				-- ["i"] = "@call.inner",
				-- ["a"] = "@call.outer",
				-- ["a"] = "@comment.outer",
				-- ["iF"] = "@frame.inner",
				-- ["oF"] = "@frame.outer",
				["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["ip"] = "@parameter.inner",
				["ap"] = "@parameter.outer",
				-- ["iS"] = "@scopename.inner",
				-- ["aS"] = "@statement.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = { ["'>"] = "@parameter.inner" },
			swap_previous = { ["'<"] = "@parameter.inner" },
		},
		move = {
			enable = true,
			goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
			goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
			goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
			goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
		},
	},
	textsubjects = {
		enable = false,
		-- prev_selection = "Q",
		keymaps = {
			["."] = "textsubjects-smart",
			["<Tab>"] = "textsubjects-container-outer",
			["<S-Tab>"] = "textsubjects-container-inner",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 300,
		disable = { "cpp" }, -- please disable lua and bash for now
	},
	pairs = {
		enable = true,
		disable = {},
		highlight_pair_events = { "CursorMoved" },                  -- when to highlight the pairs, use {} to deactivate highlighting
		highlight_self = true,
		goto_right_end = false,                                     -- whether to go to the end of the right partner or the beginning
		fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
		keymaps = { goto_partner = "'%" },
	},
	matchup = {
		enable = false,
		disable = {},
	},
	endwise = {
		enable = true,
	},
	ts_context_commentstring = { enable = true },
	yati = { enable = true, disable = { "markdown" }, default_lazy = true },
	tree_setter = { enable = true },
})
