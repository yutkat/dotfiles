vim.notify = require("notify")
require("overseer").setup({
	task_list = {
		bindings = {
			["<Tab>"] = "IncreaseDetail",
			["<S-Tab>"] = "DecreaseDetail",
			["gh"] = "IncreaseAllDetail",
			["gl"] = "DecreaseAllDetail",
		},
	},
})
local overseer = require("overseer")

local previous_cmd = ""
local previous_win = nil

vim.api.nvim_create_user_command("T", function(param)
	if previous_win then
		vim.api.nvim_win_close(previous_win, true)
	end
	-- vim.cmd("OverseerOpen!")
	vim.cmd("OverseerRunCmd " .. param.args)
	vim.cmd("OverseerQuickAction open hsplit")
	vim.cmd("resize 30")
	previous_win = vim.api.nvim_get_current_win()
	vim.cmd.wincmd({ args = { "p" }, mods = { noautocmd = true } })
	previous_cmd = param.args
end, { nargs = "?", force = true })

-- local opts = { module = "shell" }
-- local hook = function(task_defn, util)
-- 	util.add_component(task_defn, { "on_output_quickfix", open = true })
-- end
-- overseer.add_template_hook(opts, hook)
vim.keymap.set("n", "[_Make]m", "<Cmd>OverseerToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Make]q", "<Cmd>OverseerToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Make]r", function()
	vim.cmd("OverseerOpen!")
	vim.cmd("OverseerRunCmd " .. previous_cmd)
end, { noremap = true, silent = true })
