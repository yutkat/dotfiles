if has('autocmd')
  augroup MyVimrc
    autocmd!
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
    autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
    autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
  augroup END
endif
