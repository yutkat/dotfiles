local Hydra = require("hydra")

Hydra({
	name = "Side scroll",
	mode = "n",
	body = "g<C-w>",
	heads = {
		{ "h", "5zh" },
		{ "l", "5zl", { desc = "←/→" } },
		{ "H", "zH" },
		{ "L", "zL", { desc = "half screen ←/→" } },
	},
})
