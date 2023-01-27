do
	require("insx.preset.standard").setup()
	local insx = require("insx")
	local endwise = require("insx.recipe.endwise")
	insx.add("<CR>", endwise.recipe(endwise.builtin))
end
