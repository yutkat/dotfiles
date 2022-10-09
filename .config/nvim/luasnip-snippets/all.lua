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

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, format)
	local n_fmt = format or "%Y-%m-%d"
	return sn(nil, i(1, os.date(n_fmt)))
end

return {
	-- trigger is fn.
	s("fn", {
		-- Simple static text.
		t("//Parameters: "), -- function, first parameter is the function, second the Placeholders
		-- whose text it gets as input.
		f(copy, 2),
		t({ "", "function " }), -- Placeholder/Insert.
		i(1),
		t("("), -- Placeholder with initial text.
		i(2, "int foo"), -- Linebreak
		t({ ") {", "\t" }),
		-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
		i(0),
		t({ "", "}" }),
	}),
	s("class", {
		-- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
		c(1, { t("public "), t("private ") }),
		t("class "),
		i(2),
		t(" "),
		c(3, {
			t("{"),
			-- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
			-- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
			sn(nil, {
				t("extends "), -- restoreNode: stores and restores nodes.
				-- pass position, store-key and nodes.
				r(1, "other_class", i(1)),
				t(" {"),
			}),
			sn(nil, {
				t("implements "), -- no need to define the nodes for a given key a second time.
				r(1, "other_class"),
				t(" {"),
			}),
		}),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}), -- Alternative printf-like notation for defining snippets. It uses format
	-- string with placeholders similar to the ones used with Python's .format().
	s("fmt1", fmt("To {title} {} {}.", { i(2, "Name"), i(3, "Surname"), title = c(1, { t("Mr."), t("Ms.") }) })),
	-- To escape delimiters use double them, e.g. `{}` -> `{{}}`.
	-- Multi-line format strings by default have empty first/last line removed.
	-- Indent common to all lines is also removed. Use the third `opts` argument
	-- to control this behaviour.
	s(
		"fmt2",
		fmt(
			[[
    foo({1}, {3}) {{
      return {2} * {4}
    }}
    ]],
			{ i(1, "x"), rep(1), i(2, "y"), rep(2) }
		)
	),
	-- Empty placeholders are numbered automatically starting from 1 or the last
	-- value of a numbered placeholder. Named placeholders do not affect numbering.
	s("fmt3", fmt("{} {a} {} {1} {}", { t("1"), t("2"), a = t("A") })),
	-- The delimiters can be changed from the default `{}` to something else.
	s("fmt4", fmt("foo() { return []; }", i(1, "x"), { delimiters = "[]" })),
	-- `fmta` is a convenient wrapper that uses `<>` instead of `{}`.
	s("fmt5", fmta("foo() { return <>; }", i(1, "x"))),
	-- By default all args must be used. Use strict=false to disable the check
	s("fmt6", fmt("use {} only", { t("this"), t("not this") }, { strict = false })),
	-- Use a dynamic_node to interpolate the output of a
	-- function (see date_input above) into the initial
	-- value of an insert_node.
	s("novel", {
		t("It was a dark and stormy night on "),
		d(1, date_input, {}, { user_args = { "%A, %B %d of %Y" } }),
		t(" and the clocks were striking thirteen."),
	}), -- Parsing snippets: First parameter: Snippet-Trigger, Second: Snippet body.
	-- Placeholders are parsed into choices with 1. the placeholder text(as a snippet) and 2. an empty string.
	-- This means they are not SELECTed like in other editors/Snippet engines.
	ls.parser.parse_snippet("lspsyn", "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"),

	-- When wordTrig is set to false, snippets may also expand inside other words.
	ls.parser.parse_snippet({ trig = "te", wordTrig = false }, "${1:cond} ? ${2:true} : ${3:false}"),

	-- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
	ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
	-- Using the condition, it's possible to allow expansion only in specific cases.
	s("cond", { t("will only expand in c-style comments") }, {
		condition = function(line_to_cursor, matched_trigger, captures)
			-- optional whitespace followed by //
			return line_to_cursor:match("%s*//")
		end,
	}), -- there's some built-in conditions in "luasnip.extras.conditions.expand".
	s("cond2", { t("will only expand at the beginning of the line") }, { condition = conds.line_begin }),
	-- The last entry of args passed to the user-function is the surrounding snippet.
	s(
		{ trig = "a%d", regTrig = true },
		f(function(_, snip)
			return "Triggered with " .. snip.trigger .. "."
		end, {})
	),
	-- It's possible to use capture-groups inside regex-triggers.
	s(
		{ trig = "b(%d)", regTrig = true },
		f(function(_, snip)
			return "Captured Text: " .. snip.captures[1] .. "."
		end, {})
	),
	s({ trig = "c(%d+)", regTrig = true }, { t("will only expand for even numbers") }, {
		condition = function(line_to_cursor, matched_trigger, captures)
			return tonumber(captures[1]) % 2 == 0
		end,
	}), -- Use a function to execute any shell command and print its text.
	s("bash", f(bash, {}, "ls")),
	-- Short version for applying String transformations using function nodes.
	s("transform", {
		i(1, "initial text"),
		t({ "", "" }),
		-- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
		-- This list will be applied in order to the first node given in the second argument.
		l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
	}),
	s("transform2", {
		i(1, "initial text"),
		t("::"),
		i(2, "replacement for e"),
		t({ "", "" }),
		-- Lambdas can also apply transforms USING the text of other nodes:
		l(l._1:gsub("e", l._2), { 1, 2 }),
	}),
	s({ trig = "trafo(%d+)", regTrig = true }, {
		-- env-variables and captures can also be used:
		l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
	}), -- Set store_selection_keys = "<Tab>" (for example) in your
	-- luasnip.config.setup() call to access TM_SELECTED_TEXT. In
	-- this case, select a URL, hit Tab, then expand this snippet.
	s("link_url", {
		t('<a href="'),
		f(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}),
		t('">'),
		i(1),
		t("</a>"),
		i(0),
	}), -- Shorthand for repeating the text in a given node.
	s("repeat", { i(1, "text"), t({ "", "" }), rep(1) }),
	-- Directly insert the ouput from a function evaluated at runtime.
	s("part", p(os.date, "%Y")),
	-- use matchNodes to insert text based on a pattern/function/lambda-evaluation.
	s("mat", { i(1, { "sample_text" }), t(": "), m(1, "%d", "contains a number", "no number :(") }),
	-- The inserted text defaults to the first capture group/the entire
	-- match if there are none
	s("mat2", { i(1, { "sample_text" }), t(": "), m(1, "[abc][abc][abc]") }),
	-- It is even possible to apply gsubs' or other transformations
	-- before matching.
	s("mat3", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, l._1:gsub("[123]", ""):match("%d"), "contains a number that isn't 1, 2 or 3!"),
	}), -- `match` also accepts a function, which in turn accepts a string
	-- (text in node, \n-concatted) and returns any non-nil value to match.
	-- If that value is a string, it is used for the default-inserted text.
	s("mat4", {
		i(1, { "sample_text" }),
		t(": "),
		m(1, function(text)
			return (#text % 2 == 0 and text) or nil
		end),
	}), -- The nonempty-node inserts text depending on whether the arg-node is
	-- empty.
	s("nempty", { i(1, "sample_text"), n(1, "i(1) is not empty!") }),
	-- dynamic lambdas work exactly like regular lambdas, except that they
	-- don't return a textNode, but a dynamicNode containing one insertNode.
	-- This makes it easier to dynamically set preset-text for insertNodes.
	s("dl1", { i(1, "sample_text"), t({ ":", "" }), dl(2, l._1, 1) }),
	-- Obviously, it's also possible to apply transformations, just like lambdas.
	s("dl2", {
		i(1, "sample_text"),
		i(2, "sample_text_2"),
		t({ "", "" }),
		dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
	}),
},
	{
		type = "autosnippets",
		key = "all_auto",
	}
