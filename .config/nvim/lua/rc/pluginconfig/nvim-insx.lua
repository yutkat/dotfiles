-- require("insx.preset.standard").setup({ cmdline = { enabled = true } })
local insx = require("insx")
local esc = require("insx.helper.regex").esc
local helper = require("insx.helper")

local function auto_tag()
	local search = {}
	search.Tag = {
		Open = [=[<\(\w\+\)\%(\s\+.\{-}\)\?]=],
		Close = [=[</\w\+>]=],
	}
	return {
		builtin = {
			["html"] = {
				{
					action = function(ctx)
						local name = ctx.before():match("<(%w+)")
						local row, col = ctx.row(), ctx.col()
						ctx.move(row, col + 1)
						ctx.send(([[</%s>]]):format(name))
						ctx.move(row, col + 1)
					end,
					enabled = function(ctx)
						return helper.regex.match(ctx.before(), search.Tag.Open) ~= nil
							and helper.regex.match(ctx.after(), helper.search.Tag.Close) == nil
					end,
				},
			},
		},
	}
end

-- endwise
local endwise = require("insx.recipe.endwise")
insx.add("<CR>", endwise(endwise.builtin))
insx.add(">", endwise(auto_tag().builtin))

-- quotes
for _, quote in ipairs({ '"', "`" }) do
	-- jump_out
	insx.add(
		quote,
		require("insx.recipe.jump_next")({
			jump_pat = {
				[[\\\@<!\%#]] .. esc(quote) .. [[\zs]],
			},
		})
	)

	-- auto_pair
	insx.add(
		quote,
		insx.with(
			require("insx.recipe.auto_pair")({
				open = quote,
				close = quote,
			}),
			{
				insx.with.in_string(false),
				insx.with.in_comment(false),
				insx.with.nomatch([[\%#\w]]),
				insx.with.undopoint(),
			}
		)
	)

	-- delete_pair
	insx.add(
		"<BS>",
		insx.with(
			require("insx.recipe.delete_pair").strings({
				open_pat = esc(quote),
				close_pat = esc(quote),
			}),
			{
				insx.with.in_string(false),
				insx.with.in_comment(false),
				insx.with.nomatch(([[\\%s\%%#]]):format(esc(quote))),
			}
		)
	)
end

-- single quote '
insx.add(
	"'",
	require("insx.recipe.jump_next")({
		jump_pat = {
			[[\\\@<!\%#]] .. esc("'") .. [[\zs]],
		},
	})
)

insx.add(
	"'",
	insx.with(
		require("insx.recipe.auto_pair").strings({
			open = "'",
			close = "'",
			ignore_pat = { [[\%#\w]], [[\a\%#]] },
		}),
		{
			insx.with.in_string(false),
			insx.with.in_comment(false),
			insx.with.nomatch([[\%#\w]]),
			insx.with.nomatch([[\a\%#]]),
			insx.with.undopoint(),
		}
	)
)

insx.add(
	"<BS>",
	insx.with(
		require("insx.recipe.delete_pair").strings({
			open_pat = esc("'"),
			close_pat = esc("'"),
		}),
		{
			insx.with.in_string(false),
			insx.with.in_comment(false),
			insx.with.nomatch(([[\\%s\%%#]]):format(esc("'"))),
		}
	)
)

-- pairs
for open, close in pairs({
	["("] = ")",
	["["] = "]",
	["{"] = "}",
}) do
	-- jump_out
	insx.add(
		close,
		require("insx.recipe.jump_next")({
			jump_pat = {
				[[\%#]] .. esc(close) .. [[\zs]],
			},
		})
	)

	-- auto_pair
	insx.add(
		open,
		insx.with(
			require("insx.recipe.auto_pair")({
				open = open,
				close = close,
			}),
			{
				insx.with.in_string(false),
				insx.with.in_comment(false),
				insx.with.nomatch([[\%#\w]]),
				insx.with.undopoint(),
			}
		)
	)

	-- delete_pair
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair")({
			open_pat = esc(open),
			close_pat = esc(close),
		})
	)

	-- spacing
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

	-- fast_break
	insx.add(
		"<CR>",
		require("insx.recipe.fast_break")({
			open_pat = esc(open),
			close_pat = esc(close),
			html_attrs = true,
			arguments = true,
		})
	)

	-- fast_wrap
	insx.add(
		"<C-]>",
		require("insx.recipe.fast_wrap")({
			close = close,
		})
	)
end

-- quotes
for _, quote in ipairs({ '"', "'", "`" }) do
	-- jump_out
	insx.add(
		quote,
		require("insx.recipe.jump_next")({
			jump_pat = {
				[[\\\@<!\%#]] .. esc(quote) .. [[\zs]],
			},
		}),
		{ mode = "c" }
	)

	-- auto_pair
	insx.add(
		quote,
		insx.with(
			require("insx.recipe.auto_pair").strings({
				open = quote,
				close = quote,
			}),
			{ insx.with.nomatch([[\%#\w]]) }
		),
		{ mode = "c" }
	)

	-- delete_pair
	-- insx.add(
	-- 	"<BS>",
	-- 	insx.with(
	-- 		require("insx.recipe.delete_pair").strings({
	-- 			open_pat = esc(quote),
	-- 			close_pat = esc(quote),
	-- 		}),
	-- 		{ insx.with.nomatch([[\%#\w]]) }
	-- 	),
	-- 	{ mode = "c" }
	-- )
end

-- pairs
for open, close in pairs({
	["("] = ")",
	["["] = "]",
	["{"] = "}",
}) do
	-- jump_out
	insx.add(
		close,
		require("insx.recipe.jump_next")({
			jump_pat = {
				[[\%#]] .. esc(close) .. [[\zs]],
			},
		}),
		{ mode = "c" }
	)

	-- auto_pair
	insx.add(
		open,
		insx.with(
			require("insx.recipe.auto_pair")({
				open = open,
				close = close,
			}),
			{ insx.with.nomatch([[\%#\w]]) }
		),
		{ mode = "c" }
	)

	-- delete_pair
	-- insx.add(
	-- 	"<BS>",
	-- 	insx.with(
	-- 		require("insx.recipe.delete_pair").strings({
	-- 			open_pat = esc(open),
	-- 			close_pat = esc(close),
	-- 		}),
	-- 		{ insx.with.nomatch([[\%#\w]]) }
	-- 	),
	-- 	{ mode = "c" }
	-- )
end
