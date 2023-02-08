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
local previous_cmd = ""
local previous_win = nil

vim.api.nvim_create_user_command("T", function(param)
	if previous_win and vim.api.nvim_win_is_valid(previous_win) then
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
	if previous_cmd == "" then
		vim.notify("Please start T with arguments")
		return
	end
	vim.cmd("T " .. previous_cmd)
end, { noremap = true, silent = true })

local group_name = "vimrc_overseer"
vim.api.nvim_create_augroup(group_name, { clear = true })
vim.api.nvim_create_autocmd({ "TermClose" }, {
	group = group_name,
	pattern = "term://*",
	callback = function()
		if previous_win and vim.api.nvim_win_is_valid(previous_win) then
			print(previous_win)
			local buf = vim.api.nvim_win_get_buf(previous_win)
			local line = vim.api.nvim_buf_line_count(buf)
			vim.api.nvim_win_set_cursor(previous_win, { line, 0 })
		end
	end,
	once = false,
	nested = true,
})
