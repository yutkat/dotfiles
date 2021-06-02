let g:asyncrun_open = float2nr(&lines * 0.25)
" https://github.com/skywind3000/asyncrun.vim/blob/58d23e70569994b36208ed2a653f0a2d75c24fbc/doc/asyncrun.txt#L181
augroup vimrc_asyncrun
  autocmd!
  autocmd User AsyncRunStop copen | $ | wincmd p
augroup END

function s:re_async_run()
  if empty(g:asyncrun_info)
    echom "Please start AsyncRun with arguments"
    return
  endif
  execute 'AsyncRun ' . g:asyncrun_info
endfunction

command! AsyncRunLast call s:re_async_run()

nmap <make>r <Cmd>AsyncRunLast<CR>
cabbrev <expr> A (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "A" : "AsyncRun"
