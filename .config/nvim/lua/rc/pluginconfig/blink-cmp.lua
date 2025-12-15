require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "buffer", "snippets", "copilot", "ripgrep" },
		providers = {
			lsp = {
				score_offset = 50,
			},
			path = {
				opts = {
					get_cwd = function()
						return vim.fn.getcwd()
					end,
				},
			},
			buffer = {
				score_offset = -10,
			},
			snippets = {
				score_offset = 0,
			},
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
			ripgrep = {
				name = "Ripgrep",
				module = "blink-ripgrep",
				score_offset = -30,
			},
		},
	},
	snippets = { preset = "luasnip" },
	completion = {
		list = { selection = { preselect = false } },
		-- trigger = { show_in_snippet = false }
		documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = false },
	},
	signature = { enabled = true },
	keymap = {
		preset = "super-tab",
		["<CR>"] = { "accept", "fallback" },
		["<Up>"] = {},
		["<Down>"] = {},
	},
	cmdline = {
		completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
		keymap = {
			preset = "super-tab",
			["<CR>"] = { "accept", "fallback" },
			["<Up>"] = {},
			["<Down>"] = {},
		},
	},
})
