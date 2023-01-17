do
	local insx = require("insx")
	local esc = insx.helper.regex.esc

	-- Endwise (experimental).
	local endwise = require("insx.recipe.endwise")
	insx.add("<CR>", endwise.recipe(endwise.builtin))

	-- Leave symbols.
	for _, s in ipairs({ ")", "]", "}", ">", '"', "'", "`" }) do
		insx.add(
			s,
			require("insx.recipe.jump_next")({
				symbol_pat = {
					esc(s),
				},
			})
		)
	end

	-- Quotes
	for open, close in pairs({
		["'"] = "'",
		['"'] = '"',
		["`"] = "`",
	}) do
		-- Basic pairwise functionality.
		insx.add(
			open,
			require("insx.recipe.auto_pair")({
				open = open,
				close = close,
			})
		)
		insx.add(
			"<BS>",
			require("insx.recipe.delete_pair")({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)
	end

	-- Pairs.
	for open, close in pairs({
		["("] = ")",
		["["] = "]",
		["{"] = "}",
		["<"] = ">",
	}) do
		-- Basic pairwise functionality.
		insx.add(
			open,
			require("insx.recipe.auto_pair")({
				open = open,
				close = close,
			})
		)
		insx.add(
			"<BS>",
			require("insx.recipe.delete_pair")({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)

		-- Increase/decrease spacing.
		insx.add(
			"<Space>",
			require("insx.recipe.pair_spacing").increase({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)
		insx.add(
			"<BS>",
			require("insx.recipe.pair_spacing").decrease({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)

		-- Wrap next token: `(|)func(...)` -> `)` -> `(func(...)|)`
		insx.add(
			"<Del>",
			require("insx.recipe.fast_wrap")({
				close = close,
			})
		)

		-- Break pairs: `(|)` -> `<CR>` -> `(<CR>|<CR>)`
		insx.add(
			"<CR>",
			require("insx.recipe.fast_break")({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)
	end

	-- Remove HTML Tag: `<div>|</div>` -> `<BS>` -> `|`
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair")({
			open_pat = insx.helper.search.Tag.Open,
			close_pat = insx.helper.search.Tag.Close,
		})
	)

	-- Break HTML Tag: `<div>|</div>` -> `<BS>` -> `<div><CR>|<CR></div>`
	insx.add(
		"<CR>",
		require("insx.recipe.fast_break")({
			open_pat = insx.helper.search.Tag.Open,
			close_pat = insx.helper.search.Tag.Close,
		})
	)
end
