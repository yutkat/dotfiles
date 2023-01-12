do
	local minx = require("minx")
	local esc = minx.helper.regex.esc

	-- Endwise (experimental).
	local endwise = require("minx.recipe.endwise")
	minx.add("<CR>", endwise.recipe(endwise.builtin))

	-- Leave symbols.
	for _, s in ipairs({ ")", "]", "}", ">", '"', "'", "`" }) do
		minx.add(
			s,
			require("minx.recipe.leave_symbol")({
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
		minx.add(
			open,
			require("minx.recipe.auto_pair")({
				open = open,
				close = close,
			})
		)
		minx.add(
			"<BS>",
			require("minx.recipe.delete_pair")({
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
		minx.add(
			open,
			require("minx.recipe.auto_pair")({
				open = open,
				close = close,
			})
		)
		minx.add(
			"<BS>",
			require("minx.recipe.delete_pair")({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)

		-- Increase/decrease spacing.
		minx.add(
			"<Space>",
			require("minx.recipe.pair_spacing").increase_pair_spacing({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)
		minx.add(
			"<BS>",
			require("minx.recipe.pair_spacing").decrease_pair_spacing({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)

		-- Wrap next token: `(|)func(...)` -> `)` -> `(func(...)|)`
		minx.add(
			"<Del>",
			require("minx.recipe.fast_wrap")({
				close = close,
			})
		)

		-- Break pairs: `(|)` -> `<CR>` -> `(<CR>|<CR>)`
		minx.add(
			"<CR>",
			require("minx.recipe.fast_break")({
				open_pat = esc(open),
				close_pat = esc(close),
			})
		)
	end

	-- Remove HTML Tag: `<div>|</div>` -> `<BS>` -> `|`
	minx.add(
		"<BS>",
		require("minx.recipe.delete_pair")({
			open_pat = minx.helper.search.Tag.Open,
			close_pat = minx.helper.search.Tag.Close,
		})
	)

	-- Break HTML Tag: `<div>|</div>` -> `<BS>` -> `<div><CR>|<CR></div>`
	minx.add(
		"<CR>",
		require("minx.recipe.fast_break")({
			open_pat = minx.helper.search.Tag.Open,
			close_pat = minx.helper.search.Tag.Close,
		})
	)
end
