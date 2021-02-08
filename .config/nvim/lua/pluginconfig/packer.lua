vim.cmd('augroup vimrc_packer')
vim.cmd('autocmd!')
vim.cmd('autocmd BufWritePost .config/nvim/lua/pluginlist.lua,.config/nvim/rc/pluginconfig/*.vim,.config/nvim/rc/pluginsetup/*.vim,.config/nvim/lua/pluginconfig/*.lua PackerCompile')
vim.cmd('augroup END')
