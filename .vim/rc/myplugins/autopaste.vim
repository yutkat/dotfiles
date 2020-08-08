
if exists('g:loaded_autopaste')
  finish
endif
let g:loaded_autopaste = 1

function! s:SetPasteMode() abort
  if &term =~? 'xterm' || &term =~? 'screen' || &term =~? 'rxvt'
    " let &t_SI .= "\<Esc>[?2004h"
    " let &t_EI .= "\<Esc>[?2004l"
    let &t_ti .= "\<Esc>[?2004h"
    let &t_te .= "\<Esc>[?2004l"

    function! s:XTermPasteBegin(ret) abort
      set pastetoggle=<f29>
      set paste
      return a:ret
    endfunction

    execute "set <f28>=\<Esc>[200~"
    execute "set <f29>=\<Esc>[201~"
    "map <expr> <f28> <SID>XTermPasteBegin("i")
    imap <expr> <f28> <SID>XTermPasteBegin("<C-g>u")
    "vmap <expr> <f28> <SID>XTermPasteBegin("c")
    cmap <f28> <nop>
    cmap <f29> <nop>
  endif
endfunction


if has('nvim')
  if !has("patch-8.0.0210")
    call s:SetPasteMode()
  endif
else
  if has("patch-8.0.0238")
    " Bracketed Paste Mode対応バージョン(8.0.0238以降)では、特に設定しない
    " 場合はTERMがxtermの時のみBracketed Paste Modeが使われる。
    " tmux利用時はTERMがscreenなので、Bracketed Paste Modeを利用するには
    " 以下の設定が必要となる。
    if &term =~? 'xterm' || &term =~? 'screen' || &term =~? 'rxvt'
      let &t_BE = "\e[?2004h"
      let &t_BD = "\e[?2004l"
      exec "set t_PS=\e[200~"
      exec "set t_PE=\e[201~"
    endif
  else
    if has("patch-8.0.0210")
      set t_BE=
    endif
    call s:SetPasteMode()
  endif
endif

