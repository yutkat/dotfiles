
if &term =~? 'xterm' || &term =~? 'screen'
  function! WrapForTmux(s)
    " Remove all wrapping
    return a:s
  endfunction

  let &t_ti .= WrapForTmux("\<Esc>[?2004h")
  let &t_te .= WrapForTmux("\<Esc>[?2004l")

  function! XTermPasteBegin(ret)
    set pastetoggle=<f29>
    set paste
    return a:ret
  endfunction

  execute "set <f28>=\<Esc>[200~"
  execute "set <f29>=\<Esc>[201~"
  "map <expr> <f28> XTermPasteBegin("i")
  imap <expr> <f28> XTermPasteBegin("<C-g>u")
  "vmap <expr> <f28> XTermPasteBegin("c")
  cmap <f28> <nop>
  cmap <f29> <nop>

endif

