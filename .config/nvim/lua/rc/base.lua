if vim.fn.has("unix") == 1 then
	vim.env.LANG = "C.UTF-8"
else
	vim.env.LANG = "en"
end
vim.cmd.language(vim.env.LANG)
vim.o.langmenu = vim.env.LANG

vim.o.encoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,sjis,latin1"
vim.o.fileformats = "unix,dos,mac"
-- vim.cmd [[ scriptencoding utf-8 ]]

vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spec = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.load_black = 1
vim.g.loaded_fzf = 1
vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_pythonx_provider = 0
vim.g.loaded_ruby_provider = 0
-- https://github.com/neovim/neovim/issues/14090#issuecomment-1177933661
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

vim.opt.runtimepath:remove("/etc/xdg/nvim")
vim.opt.runtimepath:remove("/etc/xdg/nvim/after")
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
