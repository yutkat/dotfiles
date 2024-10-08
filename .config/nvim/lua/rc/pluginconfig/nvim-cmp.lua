vim.g.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")
local has_words_before = function()
	local unpack = unpack or table.unpack ---@diagnostic disable-line: deprecated
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
	performance = {
		debounce = 0, -- default is 60ms
		throttle = 0, -- default is 30ms
	},
	formatting = {
		-- fields = {'abbr', 'kind', 'menu'},
		format = require("lspkind").cmp_format({
			with_text = true,
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				cmp_tabnine = "[TabNine]",
				copilot = "[Copilot]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[NeovimLua]",
				latex_symbols = "[LaTeX]",
				path = "[Path]",
				omni = "[Omni]",
				spell = "[Spell]",
				emoji = "[Emoji]",
				calc = "[Calc]",
				rg = "[Rg]",
				treesitter = "[TS]",
				dictionary = "[Dictionary]",
				mocword = "[mocword]",
				cmdline = "[Cmd]",
				cmdline_history = "[History]",
			},
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			function(entry1, entry2)
				local kind1 = entry1:get_kind()
				kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
				local kind2 = entry2:get_kind()
				kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
				if kind1 ~= kind2 then
					if kind1 == types.lsp.CompletionItemKind.Snippet then
						return false
					end
					if kind2 == types.lsp.CompletionItemKind.Snippet then
						return true
					end
					local diff = kind1 - kind2
					if diff < 0 then
						return true
					elseif diff > 0 then
						return false
					end
				end
			end,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},

	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- selene: allow(unused_variable)
		---@diagnostic disable-next-line: unused-local
		["<Up>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				vim.api.nvim_feedkeys(t("<Up>"), "n", true)
			end
		end, { "i" }),
		-- selene: allow(unused_variable)
		---@diagnostic disable-next-line: unused-local
		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				vim.api.nvim_feedkeys(t("<Down>"), "n", true)
			end
		end, { "i" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif luasnip.expand_or_jumpable() then
				-- 	luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-Down>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-Up>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,                   -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	-- LuaFormatter off
	sources = cmp.config.sources({
		{ name = "copilot",                 priority = 90 }, -- For luasnip users.
		{ name = "nvim_lsp",                priority = 100 },
		{ name = "cmp_tabnine",             priority = 30 },
		{ name = "luasnip",                 priority = 20 }, -- For luasnip users.
		{ name = "path",                    priority = 100 },
		{ name = "emoji",                   insert = true, priority = 60 },
		{ name = "nvim_lua",                priority = 50 },
		{ name = "nvim_lsp_signature_help", priority = 80 },
	}, {
		{ name = "buffer",     priority = 50 },
		-- slow
		-- { name = "omni", priority = 40 },
		{ name = "spell",      priority = 40 },
		{ name = "calc",       priority = 50 },
		{ name = "treesitter", priority = 30 },
		{ name = "dictionary", keyword_length = 2, priority = 10 },
	}),
	-- LuaFormatter on
})

cmp.setup.filetype({ "gitcommit", "markdown" }, {
	sources = cmp.config.sources({
		{ name = "copilot",     priority = 90 }, -- For luasnip users.
		{ name = "nvim_lsp",    priority = 100 },
		{ name = "cmp_tabnine", priority = 30 },
		{ name = "luasnip",     priority = 80 }, -- For luasnip users.
		{ name = "rg",          priority = 70 },
		{ name = "path",        priority = 100 },
		{ name = "emoji",       insert = true, priority = 60 },
	}, {
		{ name = "buffer",     priority = 50 },
		-- { name = "omni", priority = 40 },
		{ name = "spell",      priority = 40 },
		{ name = "calc",       priority = 50 },
		{ name = "treesitter", priority = 30 },
		{ name = "mocword",    priority = 60 },
		{ name = "dictionary", keyword_length = 2, priority = 10 },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
		-- { name = "cmdline_history" },
		{ name = "buffer" },
	}, {}),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "c" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "c" }),
		["<C-y>"] = {
			c = cmp.mapping.confirm({ select = false }),
		},
		["<C-q>"] = {
			c = cmp.mapping.abort(),
		},
	},
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" }, { { name = "cmdline_history" } } }),
})

-- cmp.event:on("menu_opened", function()
-- 	vim.b.copilot_suggestion_hidden = true
-- end)
--
-- cmp.event:on("menu_closed", function()
-- 	vim.b.copilot_suggestion_hidden = false
-- end)
-- autopairs
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
