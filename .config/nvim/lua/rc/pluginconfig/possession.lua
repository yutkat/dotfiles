local Path = require("plenary.path")
local ignore_filetypes = { "gitcommit", "gitrebase" }

local function get_dir_pattern()
	local pattern = "/"
	if vim.fn.has("win32") == 1 then
		pattern = "[\\:]"
	end
	return pattern
end

local function is_normal_buffer(buffer)
	local buftype = vim.api.nvim_get_option_value("buftype", { buf = buffer })
	if #buftype == 0 then
		if not vim.api.nvim_get_option_value("buflisted", { buf = buffer }) then
			vim.api.nvim_buf_delete(buffer, { force = true })
			return false
		end
	elseif buftype ~= "terminal" then
		vim.api.nvim_buf_delete(buffer, { force = true })
		return false
	end
	return true
end

-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function is_empty_buffer(buffer)
	if vim.api.nvim_buf_line_count(buffer) == 1 and vim.api.nvim_buf_get_lines(buffer, 0, 1, false)[1] == "" then
		return true
	end
	return false
end

local function is_restorable(buffer)
	local n = vim.api.nvim_buf_get_name(buffer)
	local cwd = vim.uv.cwd()
	if
			string.match(n, cwd:gsub("%W", "%%%0") .. "/%s*")
			and vim.api.nvim_buf_is_valid(buffer)
			and is_normal_buffer(buffer)
			and vim.fn.filereadable(n) == 1
	then
		return true
	end
	return false
end

local session_dir = (Path:new(vim.fn.stdpath("state")) / "possession"):absolute()

require("possession").setup({
	session_dir = session_dir,
	silent = true,
	load_silent = true,
	debug = false,
	prompt_no_cr = false,
	autosave = {
		current = false, -- or fun(name): boolean
		tmp = false,   -- or fun(): boolean
		tmp_name = vim.uv.cwd():gsub(get_dir_pattern(), "__"),
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
		-- selene: allow(unused_variable)
		---@diagnostic disable-next-line: unused-local
		before_save = function(name)
			if vim.fn.argc() > 0 then
				vim.api.nvim_command("%argdel")
			end
			if vim.tbl_contains(ignore_filetypes, vim.api.nvim_get_option_value("filetype", { buf = 0 })) then
				return false
			end
			for _, value in ipairs(vim.api.nvim_list_bufs()) do
				if is_restorable(value) then
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
	local tmp_name = vim.uv.cwd():gsub(get_dir_pattern(), "__")
	vim.cmd("PossessionSave!" .. tmp_name)
end, { force = true })

vim.api.nvim_create_user_command("PossessionLoadCurrent", function()
	local tmp_name = vim.uv.cwd():gsub(get_dir_pattern(), "__")
	if vim.uv.fs_stat(vim.fs.joinpath(session_dir, tmp_name) .. ".json") == nil then
		vim.cmd("Alpha")
		return
	end
	vim.cmd("PossessionLoad" .. tmp_name)
end, { force = true })

vim.api.nvim_create_augroup("vimrc_possession", { clear = true })
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	group = "vimrc_possession",
	pattern = "*",
	callback = function()
		local last_cmd = vim.fn.histget("c", -1)
		local token = string.gmatch(last_cmd, "[^%s]+")()
		if token == nil then
			return
		end
		local t = string.sub(token, #token)
		if t == "!" then
			return
		end
		vim.cmd([[PossessionSaveCurrent]])
	end,
	once = false,
})
