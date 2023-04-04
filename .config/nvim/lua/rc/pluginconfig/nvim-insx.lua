-- require("insx.preset.standard").setup({ cmdline = { enabled = true } })
-- require("insx.preset.standard").setup_cmdline_mode({ cmdline = { enabled = true } })
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
			require("insx.recipe.auto_pair").strings({
				open = quote,
				close = quote,
				ignore_pat = [[\%#\w]],
			}),
			{
				{
					enabled = function(enabled, ctx)
						return enabled(ctx) and not insx.helper.syntax.in_string_or_comment()
					end,
				},
			}
		)
	)

	-- delete_pair
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair").strings({
			open_pat = esc(quote),
			close_pat = esc(quote),
			ignore_pat = ([[\\%s\%%#]]):format(esc(quote)),
		})
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
			{
				enabled = function(enabled, ctx)
					return enabled(ctx) and not insx.helper.syntax.in_string_or_comment()
				end,
			},
		}
	)
)

insx.add(
	"<BS>",
	require("insx.recipe.delete_pair").strings({
		open_pat = esc("'"),
		close_pat = esc("'"),
		ignore_pat = ([[\\%s\%%#]]):format(esc("'")),
	})
)

-- pairs
for open, close in pairs({
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	["<"] = ">",
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
		require("insx.recipe.auto_pair").strings({
			open = open,
			close = close,
			ignore_pat = [[\%#\w]],
		})
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
	-- insx.add(
	-- 	"<CR>",
	-- 	require("insx.recipe.fast_break")({
	-- 		open_pat = esc(open),
	-- 		close_pat = esc(close),
	-- 		split = kit.get(config, { "fast_break", "split" }, true),
	-- 	})
	-- )

	-- fast_wrap
	insx.add(
		"<C-]>",
		require("insx.recipe.fast_wrap")({
			close = close,
		})
	)
end

local function auto_pair_cmdline(option)
	return {
		action = function(ctx)
			ctx.send(option.open .. option.close .. "<Left>")
		end,
		enabled = function(ctx)
			if option.ignore_pat_lua and ctx.after():sub(1):find(option.ignore_pat_lua) then
				return false
			end
			return true
		end,
	}
end

-- quotes
for _, quote in ipairs({ '"', "'", "`" }) do
	-- jump_out
	insx.add(
		quote,
		require("insx.recipe.jump_next")({
			close = quote,
			ignore_escaped = true,
		}),
		{ mode = "c" }
	)

	-- auto_pair
	insx.add(
		quote,
		auto_pair_cmdline({
			open = quote,
			close = quote,
			ignore_pat_lua = "%a",
		}),
		{ mode = "c" }
	)

	-- delete_pair
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair").strings({
			open_pat = esc(quote),
			close_pat = esc(quote),
			ignore_escaped = true,
		}),
		{ mode = "c" }
	)
end

-- pairs
for open, close in pairs({
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	["<"] = ">",
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
		auto_pair_cmdline({
			open = open,
			close = close,
			ignore_pat_lua = "%a",
		}),
		{ mode = "c" }
	)

	-- delete_pair
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair")({
			open_pat = esc(open),
			close_pat = esc(close),
		}),
		{ mode = "c" }
	)
end
