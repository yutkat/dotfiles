vim.notify = require("notify")
vim.keymap.set("n", "<BS>", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.fn.bufexists(buf) == 1 and vim.api.nvim_buf_get_option(buf, "filetype") == "notify" then
			vim.api.nvim_win_close(win, { force = false })
		end
	end
end, { noremap = true, silent = false })
