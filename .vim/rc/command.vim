
"==============================================================
"          command                                          {{{
"==============================================================

" CDC = Change to Directory of Current file
command! CDC lcd %:p:h

" Diff current buffer " :w !diff %-
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Toggle GitGutter/mark
command! LeftColumnToggle GitGutterToggle | SignatureToggleSigns

" Change indent
command! -nargs=1 IndentChange set tabstop=<args> shiftwidth=<args>

function! ReloadEncoding(args)
  execute 'e ++enc=' . a:args
endfunction
command! -nargs=1 EncodingReload :call ReloadEncoding(<f-args>)

function! SetCmdLine(args)
  let s:input = input('', a:args)
  execute s:input
  call histadd('cmd', s:input)
endfunction

" delete blank lines
command! DeleteBlankLines :call SetCmdLine(':g/^$/d')
" count word
command! CountWord :call SetCmdLine(':%s/\<<C-r><C-w>\>/&/gn')

" }}}

