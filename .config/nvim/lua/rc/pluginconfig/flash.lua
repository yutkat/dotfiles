require("flash").setup({
	search = {
		-- search/jump in all windows
		multi_window = false,
		-- search direction
		forward = true,
		-- when `false`, find only matches in the given direction
		wrap = true,
		-- Each mode will take ignorecase and smartcase into account.
		-- * exact: exact match
		-- * search: regular search
		-- * fuzzy: fuzzy search
		-- * fun(str): custom function that returns a pattern
		--   For example, to only match at the beginning of a word:
		--   mode = function(str)
		--     return "\\<" .. str
		--   end,
		-- mode = "exact",
		mode = function(str)
			return "\\<" .. str
		end,
		-- behave like `incsearch`
		-- incremental = true,
		filetype_exclude = { "notify", "noice" },
	},
	jump = {
		-- save location in the jumplist
		jumplist = true,
		-- jump position
		pos = "start", ---@type "start" | "end" | "range"
		-- add pattern to search history
		history = false,
		-- add pattern to search register
		register = false,
		-- clear highlight after jump
		nohlsearch = false,
		-- automatically jump when there is only one match
		autojump = true,
	},
	-- action to perform when picking a label.
	-- defaults to the jumping logic depending on the mode.
	action = nil,
	-- You can override the default options for a specific mode.
	-- Use it with `require("flash").jump({mode = "forward"})`
	modes = {
		-- options used when flash is activated through
		-- a regular search with `/` or `?`
		search = {
			enabled = false, -- enable flash for search
			highlight = { backdrop = false },
			jump = { history = true, register = true, nohlsearch = true },
			search = {
				-- `forward` will be automatically set to the search direction
				-- `mode` is always set to `search`
				-- `incremental` is set to `true` when `incsearch` is enabled
			},
		},
		-- options used when flash is activated through
		-- `f`, `F`, `t`, `T`, `;` and `,` motions
		char = {
			enabled = true,
			multi_line = false,
			search = { wrap = false },
			highlight = { backdrop = true, groups = { label = "", backdrop = "" } },
			jump = { register = false },
		},
		-- options used for treesitter selections
		-- `require("flash").treesitter()`
		treesitter = {
			labels = "abcdefghijklmnopqrstuvwxyz",
			jump = { pos = "range" },
			highlight = {
				label = { before = true, after = true, style = "inline" },
				backdrop = false,
				matches = false,
			},
		},
	},
})

vim.keymap.set({ "n", "x" }, "SS", function()
	require("flash").jump({
		search = { forward = false, wrap = false, multi_window = false },
	})
end)

vim.keymap.set({ "n", "x" }, "Ss", function()
	require("flash").jump({
		search = { forward = true, wrap = false, multi_window = false },
	})
end)
