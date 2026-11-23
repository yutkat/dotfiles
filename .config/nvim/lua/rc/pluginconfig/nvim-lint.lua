local lint = require("lint")

-- sh/bash/zsh (shuck), python (ruff), js/ts (biome), markdown (rumdl),
-- and rust (rustaceanvim) diagnostics come from their LSP servers.
lint.linters_by_ft = {
	lua = { "selene" },
}

lint.try_lint()

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
