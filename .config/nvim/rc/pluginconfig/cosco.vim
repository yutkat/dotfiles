augroup vimrc_cosco
  autocmd!
  autocmd FileType javascript,typescript,css,rust,c,cpp,cs,java,php imap <silent> <C-g> <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
  autocmd FileType javascript,typescript,css,rust,c,cpp,cs,java,php nmap <silent> [SubLeader]; <Plug>(cosco-commaOrSemiColon)
  autocmd FileType javascript,typescript,css,rust,c,cpp,cs,java,php imap <silent> <C-x>; <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
augroup END
