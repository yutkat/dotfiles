if has('autocmd')
  augroup MyVimrc
    autocmd!
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
    autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
  augroup END
endif
