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
		["<Tab>"] = {
			function(cmp)
				if cmp.is_visible() then
					return cmp.select_next()
				end
				if cmp.snippet_active() then
					return cmp.snippet_forward()
				end
				return cmp.fallback()
			end,
		},

		["<S-Tab>"] = {
			function(cmp)
				if cmp.is_visible() then
					return cmp.select_prev()
				end
				if cmp.snippet_active() then
					return cmp.snippet_backward()
				end
				return cmp.fallback()
			end,
		},
		["<CR>"] = { "accept", "fallback" },
		["<C-Space>"] = { "show", "fallback" },
		["<Up>"] = {},
		["<Down>"] = {},
	},
	cmdline = {
		completion = {
			menu = { auto_show = true },
			list = { selection = { preselect = false } },
		},
		keymap = {
			["<Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_next()
					end
					return cmp.fallback()
				end,
			},

			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					end
					return cmp.fallback()
				end,
			},
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<Up>"] = {},
			["<Down>"] = {},
		},
	},
})
