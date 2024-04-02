require("rc/base")

-- ===============================
local function load_my_plugins(path)
	for file, _ in vim.fs.dir(path) do
		require("rc/myplugins/" .. vim.fs.basename(path) .. "/" .. file:gsub("%.lua$", ""))
	end
end

-- ===============================
require("rc/option")
require("rc/display")
load_my_plugins(vim.fn.stdpath("config") .. "/lua/rc/myplugins/start")
require("rc/pluginlist")
require("rc/mappings")
if vim.g.vscode then
	require("rc/vscode-neovim/mappings")
end
vim.defer_fn(function()
	require("rc/command")
end, 50)
require("rc/autocmd")

-- ===============================
vim.schedule(function()
	load_my_plugins(vim.fn.stdpath("config") .. "/lua/rc/myplugins/opt")
end)

-- ===============================
-- Local Configuration
if vim.fn.filereadable(vim.fs.normalize("~/.nvim_local_init.lua")) ~= 0 then
	dofile(vim.fs.normalize("~/.nvim_local_init.lua"))
end
