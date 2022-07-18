require("nvim-surround").setup({
	keymaps = { -- vim-surround style keymaps
		insert = "sa",
		-- insert_line = "ssa",
		visual = "s",
		delete = "sd",
		change = "sr",
	},
	delimiters = {
		pairs = {
			["("] = { "( ", " )" },
			[")"] = { "(", ")" },
			["{"] = { "{ ", " }" },
			["}"] = { "{", "}" },
			["<"] = { "< ", " >" },
			[">"] = { "<", ">" },
			["["] = { "[ ", " ]" },
			["]"] = { "[", "]" },
			-- Define pairs based on function evaluations!
			["i"] = function()
				return {
					require("nvim-surround.utils").get_input("Enter the left delimiter: "),
					require("nvim-surround.utils").get_input("Enter the right delimiter: "),
				}
			end,
			["f"] = function()
				return {
					require("nvim-surround.utils").get_input("Enter the function name: ") .. "(",
					")",
				}
			end,
		},
		separators = {
			["'"] = { "'", "'" },
			['"'] = { '"', '"' },
			["`"] = { "`", "`" },
		},
		HTML = {
			["t"] = "type", -- Change just the tag type
			["T"] = "whole", -- Change the whole tag contents
		},
		aliases = {
			-- ["a"] = "a",
			["b"] = "b",
			["B"] = "B",
			["r"] = "r",
			-- Table aliases only apply for changes/deletions
			["q"] = { '"', "'", "`" }, -- Any quote character
			[";"] = { ")", "]", "}", ">", "'", '"', "`" }, -- Any surrounding delimiter
		},
	},
	highlight_motion = { -- Highlight before inserting/changing surrounds
		duration = 0,
	},
})
