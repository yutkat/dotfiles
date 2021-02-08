vim.cmd('augroup vimrc_packer')
vim.cmd('autocmd!')
vim.cmd('autocmd BufWritePost .vim/lua/pluginlist.lua,.vim/rc/pluginconfig/*.vim,.vim/rc/pluginsetup/*.vim,.vim/lua/pluginconfig/*.lua PackerCompile')
vim.cmd('augroup END')
