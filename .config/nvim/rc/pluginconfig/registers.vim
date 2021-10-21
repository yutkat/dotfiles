augroup Registers
	au!
augroup END

augroup vimrc_Registers
  au!
  au BufEnter * imap <buffer> <expr> <C-R> registers#peek('<C-R>')
augroup END
