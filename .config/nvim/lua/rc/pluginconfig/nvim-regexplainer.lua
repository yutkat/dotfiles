-- defaults
require("regexplainer").setup({
	-- 'narrative'
	mode = "narrative", -- TODO: 'ascii', 'graphical'
	-- automatically show the explainer when the cursor enters a regexp
	auto = false,
	-- Whether to log debug messages
	debug = false,
	-- 'split', 'popup'
	display = "popup",
	mappings = {
		show = "<Space>R",
	},
	narrative = {
		separator = "\n",
	},
})
