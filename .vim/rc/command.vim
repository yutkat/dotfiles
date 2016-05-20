
"==============================================================
"          command                                          {{{
"==============================================================

" CDC = Change to Directory of Current file
command! CDC lcd %:p:h

" Diff current buffer " :w !diff %-
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Toggle number/GitGutter/mark
command! LeftColumnToggle set invnumber | GitGutterToggle |
    \ SignatureToggleSigns

" }}}

