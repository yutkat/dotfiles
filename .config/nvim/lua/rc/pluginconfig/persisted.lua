local ignore_filetypes = { "gitcommit" }

require("persisted").setup({
	save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions2/"), -- directory where session files are saved
	command = "VimLeavePre", -- the autocommand for which the session is saved
	use_git_branch = false, -- create session files based on the branch of the git enabled repository
	autosave = false, -- automatically save session files when exiting Neovim
	autoload = false, -- automatically load the session for the cwd on Neovim startup
	allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
	ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
	-- do not work. because it does not handle the return value
	before_save = function()
		if vim.tbl_contains(ignore_filetypes, vim.api.nvim_get_option_value("filetype", { buf = 0 })) then
			return false
		end
		local bufs = vim.api.nvim_list_bufs()
		for _, value in ipairs(bufs) do
			local n = vim.api.nvim_buf_get_name(value)
			local cwd = vim.uv.cwd()
			print(n .. " " .. cwd)
			if string.match(n, cwd .. "/%s*") then
				return true
			end
		end
		return false
	end,
	after_save = function()
		return true
	end,
	-- telescope = { -- options for the telescope extension
	-- 	before_source = function(session) end, -- function to run before the session is sourced via telescope
	-- 	after_source = function(session) end, -- function to run after the session is sourced via telescope
	-- },
})

require("persisted").start()
