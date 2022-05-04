require("rc/base")

-- ===============================

require("rc/option")
require("rc/display")
require("rc/pluginlist")
require("rc/mappings")
require("rc/command")
require("rc/autocmd")

-- Configuration
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/rc/myplugins", [[v:val =~ '\.lua$']])) do
	require("rc/myplugins/" .. file:gsub("%.lua$", ""))
end

-- ===============================
if vim.g.vscode then
	require("rc/vscode-neovim/mappings")
end

-- ===============================

-- Local Configuration
if vim.fn.filereadable(vim.fn.expand("~/.nvim_local_init.lua")) ~= 0 then
	dofile(vim.fn.expand("~/.nvim_local_init.lua"))
end
