require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
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
		},
	},
	snippets = { preset = "luasnip" },
	completion = {
		list = { selection = { preselect = false, auto_insert = false } },
		-- trigger = { show_in_snippet = false }
		documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = false },
	},
	signature = { enabled = true },
	keymap = {
		preset = "none",
		["<Tab>"] = {
			"select_next",
			"snippet_forward",
			-- Copilot ghost text (builtin inline completion, enabled below)
			function()
				return vim.lsp.inline_completion.get()
			end,
			function()
				return require("sidekick").nes_jump_or_apply()
			end,
			"fallback",
		},
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
		["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
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
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<Up>"] = {},
			["<Down>"] = {},
		},
	},
})

-- Copilot suggestions as ghost text via copilot-language-server (replaces fang2hou/blink-copilot)
vim.lsp.inline_completion.enable()
