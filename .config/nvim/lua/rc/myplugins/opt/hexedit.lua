vim.api.nvim_create_user_command("HexEditSplit16BytePerLine", function()
	vim.cmd.normal({ 0, bang = true })
	while vim.fn.len(vim.fn.expand("<cword>")) ~= 0 do
		local cur = vim.fn.line(".")
		vim.cmd.normal({ "016E", bang = true })
		if vim.fn.line(".") ~= cur then
			break
		end
		vim.cmd.normal({ [[a\<CR>]], bang = true })
	end
end, { force = true, bar = true, range = "%" })

vim.api.nvim_create_user_command("HexEditAdd0x", function()
	vim.cmd([['<,'>s/\%V\(\w\)\(\w\)/0x\1\2/g]])
end, { force = true, bar = true, range = "%" })
vim.api.nvim_create_user_command("HexEditAddCommaEachWord", function()
	vim.cmd([['<,'>s/\%V\(\<\w*\>\)/\1\,/g]])
end, { force = true, bar = true, range = "%" })
vim.api.nvim_create_user_command("HexEditConvertHexForProg", function()
	vim.cmd([['<,'>HexEditAdd0x | '<,'>HexEditAddCommaEachWord | '<,'>HexEditSplit16BytePerLine]])
end, { force = true, bar = true, range = "%" })
