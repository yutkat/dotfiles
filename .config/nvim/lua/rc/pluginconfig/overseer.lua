vim.notify = require("notify")
require("overseer").setup({
	-- Default task strategy
	strategy = "terminal",
	-- Template modules to load
	templates = { "builtin" },
	-- When true, tries to detect a green color from your colorscheme to use for success highlight
	auto_detect_success_color = true,
	-- Patch nvim-dap to support preLaunchTask and postDebugTask
	dap = true,
	-- Configure the task list
	task_list = {
		-- Default detail level for tasks. Can be 1-3.
		default_detail = 1,
		-- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
		max_width = { 100, 0.2 },
		-- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
		min_width = { 40, 0.1 },
		-- String that separates tasks
		separator = "────────────────────────────────────────",
		-- Default direction. Can be "left" or "right"
		direction = "left",
		-- Set keymap to false to remove default behavior
		-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
		bindings = {
			["?"] = "ShowHelp",
			["<CR>"] = "RunAction",
			["<C-e>"] = "Edit",
			["o"] = "Open",
			["<C-v>"] = "OpenVsplit",
			["<C-s>"] = "OpenSplit",
			["<C-f>"] = "OpenFloat",
			["p"] = "TogglePreview",
			["<Tab>"] = "IncreaseDetail",
			["<S-Tab>"] = "DecreaseDetail",
			["gh"] = "IncreaseAllDetail",
			["gl"] = "DecreaseAllDetail",
			["["] = "DecreaseWidth",
			["]"] = "IncreaseWidth",
			["{"] = "PrevTask",
			["}"] = "NextTask",
		},
	},
	-- See :help overseer.actions
	actions = {},
	-- Configure the floating window used for task templates that require input
	-- and the floating window used for editing tasks
	form = {
		border = "rounded",
		zindex = 40,
		min_width = 80,
		max_width = 0.9,
		min_height = 10,
		max_height = 0.9,
		-- Set any window options here (e.g. winhighlight)
		win_opts = {
			winblend = 10,
		},
	},
	task_launcher = {
		-- Set keymap to false to remove default behavior
		-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
		bindings = {
			i = {
				["<C-s>"] = "Submit",
			},
			n = {
				["<CR>"] = "Submit",
				["<C-s>"] = "Submit",
				["?"] = "ShowHelp",
			},
		},
	},
	task_editor = {
		-- Set keymap to false to remove default behavior
		-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
		bindings = {
			i = {
				["<CR>"] = "NextOrSubmit",
				["<C-s>"] = "Submit",
				["<Tab>"] = "Next",
				["<S-Tab>"] = "Prev",
			},
			n = {
				["<CR>"] = "NextOrSubmit",
				["<C-s>"] = "Submit",
				["<Tab>"] = "Next",
				["<S-Tab>"] = "Prev",
				["?"] = "ShowHelp",
			},
		},
	},
	-- Configure the floating window used for confirmation prompts
	confirm = {
		border = "rounded",
		zindex = 40,
		min_width = 80,
		max_width = 0.5,
		min_height = 10,
		max_height = 0.9,
		-- Set any window options here (e.g. winhighlight)
		win_opts = {
			winblend = 10,
		},
	},
	-- Configuration for task floating windows
	task_win = {
		-- How much space to leave around the floating window
		padding = 2,
		border = "rounded",
		-- Set any window options here (e.g. winhighlight)
		win_opts = {
			winblend = 10,
		},
	},
	-- Aliases for bundles of components. Redefine the builtins, or create your own.
	component_aliases = {
		-- Most tasks are initialized with the default components
		default = {
			"on_output_summarize",
			"on_exit_set_status",
			"on_complete_notify",
			"on_complete_dispose",
		},
	},
	-- This is run before creating tasks from a template
	pre_task_hook = function(task_defn, util)
		-- util.add_component(task_defn, "on_result_diagnostics", {"timeout", timeout = 20})
		-- util.remove_component(task_defn, "on_complete_dispose")
		-- task_defn.env = { MY_VAR = 'value' }
	end,
	-- A list of components to preload on setup.
	-- Only matters if you want them to show up in the task editor.
	preload_components = {},
	-- Configure where the logs go and what level to use
	-- Types are "echo", "notify", and "file"
	log = {
		{
			type = "notify",
			level = vim.log.levels.WARN,
		},
		{
			type = "file",
			filename = "overseer.log",
			level = vim.log.levels.WARN,
		},
	},
})

local previous_cmd = ""

vim.api.nvim_create_user_command("T", function(param)
	vim.cmd("OverseerOpen!")
	vim.cmd("OverseerRunCmd " .. param.args)
	previous_cmd = param.args
end, { nargs = "?", force = true })
vim.keymap.set("n", "[Make]m", "<Cmd>OverseerToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[Make]q", "<Cmd>OverseerToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[Make]r", function()
	vim.cmd("OverseerOpen!")
	vim.cmd("OverseerRunCmd " .. previous_cmd)
end, { noremap = true, silent = true })
