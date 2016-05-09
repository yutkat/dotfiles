
"--------------------------------------------------------------
"          ColorScheme                                      {{{
"--------------------------------------------------------------

function! s:SetColorScheme()
  if has('syntax') && !exists('g:syntax_on')
    syntax on " シンタックスカラーリングオン
  endif
  set t_Co=256
  set background=dark
  try
    let g:color_scheme = 'hybrid'
    execute "colorscheme " g:color_scheme
  catch /^Vim\%((\a\+)\)\=:E185/
    let g:color_scheme = 'desert'
    execute "colorscheme " g:color_scheme
    colorscheme desert
    " ポップアップメニューの色変える
    highlight Pmenu ctermfg=Black ctermbg=Gray
    highlight PmenuSel ctermfg=Black ctermbg=Cyan
    highlight PmenuSbar ctermfg=White ctermbg=DarkGray
    highlight PmenuThumb ctermfg=DarkGray ctermbg=White
  endtry
  set cursorline
  highlight clear CursorLine
endfunction

call s:SetColorScheme()

" 読み取り専用をわかりやすく
function! s:CheckRo()
  if &readonly
    colorscheme morning
  else
    if g:colors_name != g:color_scheme
      call s:SetColorScheme()
    endif
  endif
endfunction

" Cursor style
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
elseif empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  if (v:version == 704 && has("patch687")) || v:version >= 705
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  endif
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  if (v:version == 704 && has("patch687")) || v:version >= 705
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  endif
endif

" }}}

