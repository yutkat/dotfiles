local Path = require("plenary.path")
require("possession").setup({
	session_dir = (Path:new(vim.fn.stdpath("state")) / "sessions"):absolute(),
	silent = false,
	load_silent = true,
	debug = false,
	commands = {
		save = "PossessionSave",
		load = "PossessionLoad",
		delete = "PossessionDelete",
		show = "PossessionShow",
		list = "PossessionList",
		migrate = "PossessionMigrate",
	},
	hooks = {
		-- before_save = function(name)
		-- 	return {}
		-- end,
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
				"before_load",
				vim.o.sessionoptions:match("buffer") and "before_save",
			},
			force = false,
		},
		nvim_tree = true,
		tabby = true,
	},
})
