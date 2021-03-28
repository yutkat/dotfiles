augroup vimrc_cosco
  autocmd!
  autocmd FileType javascript,css,rust,c,cpp,cs,java,php nmap <silent> <SubLeader>; <Plug>(cosco-commaOrSemiColon)
  autocmd FileType javascript,css,rust,c,cpp,cs,java,php imap <silent> <C-_> <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
  autocmd FileType javascript,css,rust,c,cpp,cs,java,php imap <silent> <C-y> <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
  autocmd FileType javascript,css,rust,c,cpp,cs,java,php imap <silent> <C-x>; <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
augroup END
