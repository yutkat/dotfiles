local groupname = "switch_buffer_improve"
vim.api.nvim_create_augroup(groupname, { clear = true })

local save_buf_view = {}
-- Save current view settings on a per-window, per-buffer basis.
vim.api.nvim_create_autocmd({ "BufLeave" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		save_buf_view[vim.api.nvim_get_current_buf()] = vim.fn.winsaveview()
	end,
	once = false,
})
-- Restore current view settings.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if save_buf_view[buf] ~= nil then
			local v = vim.fn.winsaveview()
			local atStartOfFile = v.lnum == 1 and v.col == 0
			if atStartOfFile and not vim.o.diff then
				vim.fn.winrestview(save_buf_view[buf])
			end
			save_buf_view[buf] = nil
		end
	end,
	once = false,
})
