require("auto-session").setup({
	log_level = "error",
	auto_session_enable_last_session = false,
	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
	auto_session_enabled = true,
	auto_save_enabled = false,
	auto_restore_enabled = false,
})

vim.cmd([[
  augroup vimrc_auto_session
    autocmd!
    autocmd VimLeave * SaveSession
  augroup END
]])
