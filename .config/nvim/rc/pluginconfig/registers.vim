augroup Registers
	au!
augroup END

augroup vimrc_Registers
  au!
  au BufEnter [^(telescope)] imap <buffer> <expr> <C-R> registers#peek('<C-R>')
augroup END
