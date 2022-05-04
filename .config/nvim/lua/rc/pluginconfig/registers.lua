vim.api.nvim_del_augroup_by_name("Registers")

local groupname = "vimrc_Registers"
vim.api.nvim_create_augroup(groupname, { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = groupname,
	pattern = "[^(telescope)]",
	callback = function()
		vim.keymap.set("i", "<C-R>", function()
			require("registers").registers("i")
		end, { noremap = true, silent = true, buffer = true })
	end,
	once = false,
})
