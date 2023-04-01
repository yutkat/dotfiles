require("compare-with-clipboard").setup()

vim.api.nvim_create_user_command("LineDiff1", function(opts)
	if opts.range > 0 then
		vim.cmd(opts.line1 .. "," .. opts.line2 .. "y x")
	end
end, { force = true, range = true })
vim.api.nvim_create_user_command("LineDiff2", function(opts)
	if opts.range > 0 then
		vim.cmd(opts.line1 .. "," .. opts.line2 .. "y y")
	end
end, { force = true, range = true })
vim.api.nvim_create_user_command("LineDiff", function()
	require("compare-with-clipboard").compare_registers("x", "y")
end, { force = true, range = true })
