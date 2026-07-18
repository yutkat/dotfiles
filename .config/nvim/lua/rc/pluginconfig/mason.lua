require("mason").setup({})

-- shfmt cannot parse zsh; drop the registry's bogus Zsh language mapping
local ok, shfmt = pcall(require("mason-registry").get_package, "shfmt")
if ok then
	shfmt.spec.languages = vim.tbl_filter(function(lang)
		return lang ~= "Zsh"
	end, shfmt.spec.languages)
end

vim.api.nvim_create_user_command("MasonUpgrade", function()
	local registry = require("mason-registry")
	registry.refresh()
	registry.update()
	local packages = registry.get_all_packages()
	for _, pkg in ipairs(packages) do
		if pkg:is_installed() then
			pkg:install()
		end
	end
	vim.cmd("doautocmd User MasonUpgradeComplete")
end, { force = true })
