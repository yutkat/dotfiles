vim.api.nvim_exec([[
augroup vimrc_packer
  autocmd!
  autocmd BufWritePost .config/nvim/lua/pluginlist.lua,.config/nvim/rc/pluginconfig/*.vim,.config/nvim/rc/pluginsetup/*.vim,.config/nvim/lua/pluginconfig/*.lua PackerCompile
augroup END
]], true)
