-- sp/sP: print the variable under the cursor below/above (same keys timber.nvim used).
-- Other debugprint defaults (g?p, g?v, [g/]g, ...) stay enabled.
require("debugprint").setup({
	keymaps = {
		normal = {
			variable_below = "sp",
			variable_above = "sP",
		},
		visual = {
			variable_below = "sp",
			variable_above = "sP",
		},
	},
})
