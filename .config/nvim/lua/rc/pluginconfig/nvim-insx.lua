-- require("insx.preset.standard").setup({ cmdline = { enabled = true } })
require("insx.preset.standard").setup_cmdline_mode({ cmdline = { enabled = true } })
local insx = require("insx")
local esc = require("insx.helper.regex").esc

local helper = require("insx.helper")

local function auto_tag()
	return {
		builtin = {
			["html"] = {
				{
					---@param ctx insx.ActionContext
					action = function(ctx)
						local name = ctx.before():match("<(%w+)")
						local row, col = ctx.row(), ctx.col()
						ctx.send(([[</%s>]]):format(name))
						ctx.move(row, col)
					end,
					---@param ctx insx.Context
					enabled = function(ctx)
						return helper.regex.match(ctx.before(), helper.search.Tag.Open) ~= nil
							and helper.regex.match(ctx.after(), helper.search.Tag.Close) == nil
					end,
				},
			},
		},
	}
end

-- endwise
local endwise = require("insx.recipe.endwise")
insx.add("<CR>", endwise.recipe(endwise.builtin))
insx.add(">", endwise.recipe(auto_tag().builtin))

-- quotes
for _, quote in ipairs({ '"', "'", "`" }) do
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
				ignore_pat = [[\%#\w]],
			}),
			{
				enabled = function(enabled, ctx)
					return enabled(ctx) and not insx.helper.syntax.in_string_or_comment()
				end,
			}
		)
	)

	-- delete_pair
	insx.add(
		"<BS>",
		require("insx.recipe.delete_pair")({
			open_pat = esc(quote),
			close_pat = esc(quote),
			ignore_pat = ([[\\%s\%%#]]):format(esc(quote)),
		})
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
		})
	)

	-- auto_pair
	insx.add(
		open,
		require("insx.recipe.auto_pair")({
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
