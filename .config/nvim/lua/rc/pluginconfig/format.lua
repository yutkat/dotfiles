vim.api.nvim_exec([[
augroup vimrc_format
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]], true)
