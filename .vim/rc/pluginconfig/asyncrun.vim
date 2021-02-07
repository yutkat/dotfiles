let g:asyncrun_open = float2nr(&lines * 0.25)
" https://github.com/skywind3000/asyncrun.vim/blob/58d23e70569994b36208ed2a653f0a2d75c24fbc/doc/asyncrun.txt#L181
augroup vimrc_asyncrun
  autocmd!
  autocmd User AsyncRunStop copen | $ | wincmd p
augroup END
