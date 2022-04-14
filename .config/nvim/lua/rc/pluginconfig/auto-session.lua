require("auto-session").setup({
	log_level = "error",
	auto_session_enable_last_session = false,
	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
	auto_session_enabled = true,
	auto_save_enabled = false,
	auto_restore_enabled = false,
})

vim.api.nvim_create_augroup("vimrc_auto_session", { clear = true })
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	group = "vimrc_auto_session",
	pattern = "*[^{.git/COMMIT_EDITMSG}]",
	callback = function()
		vim.cmd([[SaveSession]])
	end,
	once = false,
})
