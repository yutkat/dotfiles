local Path = require("plenary.path")
local ignore_filetypes = { "gitcommit" }

local function get_dir_pattern()
	local pattern = "/"
	if vim.fn.has("win32") == 1 then
		pattern = "[\\:]"
	end
	return pattern
end

require("possession").setup({
	session_dir = (Path:new(vim.fn.stdpath("state")) / "possession"):absolute(),
	silent = true,
	load_silent = true,
	debug = false,
	prompt_no_cr = false,
	autosave = {
		current = false, -- or fun(name): boolean
		tmp = false, -- or fun(): boolean
		tmp_name = vim.fn.getcwd():gsub(get_dir_pattern(), "__"),
		on_load = false,
		on_quit = false,
	},
	commands = {
		save = "PossessionSave",
		load = "PossessionLoad",
		delete = "PossessionDelete",
		show = "PossessionShow",
		list = "PossessionList",
		migrate = "PossessionMigrate",
	},
	hooks = {
		before_save = function(name)
			if vim.tbl_contains(ignore_filetypes, vim.api.nvim_buf_get_option(0, "filetype")) then
				return false
			end
			local bufs = vim.api.nvim_list_bufs()
			for index, value in ipairs(bufs) do
				local n = vim.api.nvim_buf_get_name(value)
				local cwd = vim.fn.getcwd()
				if string.match(n, cwd .. "/%s*") then
					return true
				end
			end
			return false
		end,
		-- after_save = function(name, user_data, aborted) end,
		-- before_load = function(name, user_data)
		-- 	return user_data
		-- end,
		-- after_load = function(name, user_data) end,
	},
	plugins = {
		close_windows = {
			hooks = { "before_save", "before_load" },
			preserve_layout = true, -- or fun(win): boolean
			match = {
				floating = true,
				buftype = {},
				filetype = {},
				custom = false, -- or fun(win): boolean
			},
		},
		delete_hidden_buffers = {
			hooks = {
				-- "before_load",
				-- vim.o.sessionoptions:match("buffer") and "before_save",
			},
			force = false,
		},
		nvim_tree = true,
		tabby = true,
		delete_buffers = false,
	},
})

vim.api.nvim_create_user_command("PossessionSaveCurrent", function()
	local tmp_name = vim.fn.getcwd():gsub(get_dir_pattern(), "__")
	vim.cmd("PossessionSave!" .. tmp_name)
end, { force = true })

vim.api.nvim_create_user_command("PossessionLoadCurrent", function()
	local tmp_name = vim.fn.getcwd():gsub(get_dir_pattern(), "__")
	vim.cmd("PossessionLoad" .. tmp_name)
end, { force = true })

vim.api.nvim_create_augroup("vimrc_possession", { clear = true })
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	group = "vimrc_possession",
	pattern = "*",
	callback = function()
		vim.cmd([[PossessionSaveCurrent]])
	end,
	once = false,
})
