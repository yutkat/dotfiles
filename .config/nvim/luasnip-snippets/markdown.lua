--# selene: allow(unused_variable)
---@diagnostic disable: unused-local
local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions.expand")

return {
	s("toc", {
		t({ "# Table of Contents",
			"<!-- toc -->",
			"<!-- tocstop -->", "" }),
	}),
	s("badge_link", {
		t({ "- [" }),
		i(1, { "repo/name" }),
		f(function(args, snip)
			return string.format(
				"](https://github.com/%s) ![](https://img.shields.io/github/stars/%s) ![](https://img.shields.io/github/last-commit/%s) ![](https://img.shields.io/github/commit-activity/y/%s)",
				args[1][1],
				args[1][1],
				args[1][1],
				args[1][1]
			)
		end, { 1 }),
	}),
}
