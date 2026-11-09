-- Check global values: buffer-local ones may be off in special buffers (e.g. snacks dashboard)
if not vim.go.undofile then
	print("Please set `:set undofile`")
	return
end

if vim.go.undodir == "" then
	print("Please set `:set undodir=$HOME/.vim/undo`")
	return
end

local groupname = "persistentundo"
vim.api.nvim_create_augroup(groupname, { clear = true })

vim.api.nvim_create_autocmd({ "BufRead" }, {
	group = groupname,
	pattern = "~/*",
	callback = function()
		vim.opt_local.undofile = true
	end,
	once = false,
})
