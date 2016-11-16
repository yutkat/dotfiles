
if &term =~? 'xterm' || &term =~? 'screen'
  function! WrapForTmux(s)
    if !exists('$TMUX')
      return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
  endfunction

  let &t_SI .= WrapForTmux("\<Esc>[?2004h")
  let &t_EI .= WrapForTmux("\<Esc>[?2004l")

  function! XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("<C-g>u")
  " normal mode off
  "noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  "cnoremap <special> <Esc>[200~ <nop>
  "cnoremap <special> <Esc>[201~ <nop>
endif

