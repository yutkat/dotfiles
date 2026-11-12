local lint = require("lint")
local function pick_linters(linters)
	for _, l in ipairs(linters) do
		if lint.linters[l] and vim.fn.executable(lint.linters[l].cmd()) == 1 then
			return { l }
		end
	end
	return {}
end
local function make_linters_by_ft()
	return {
		lua = { "selene" },
		-- sh/bash/zsh diagnostics come from the shuck LSP server
		rust = { "clippy" },
		python = { "ruff" },
		javascript = pick_linters({ "biomejs", "eslint_d" }),
		typescript = pick_linters({ "biomejs", "eslint_d" }),
	}
end

lint.linters_by_ft = make_linters_by_ft()

lint.try_lint()

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
