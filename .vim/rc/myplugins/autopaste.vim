
if exists('g:loaded_autopaste')
	finish
endif
let g:loaded_autopaste = 1

if &term =~? 'xterm' || &term =~? 'screen' || &term =~? 'rxvt'
  let &t_SI .= "\<Esc>[?2004h"
  let &t_EI .= "\<Esc>[?2004l"

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

