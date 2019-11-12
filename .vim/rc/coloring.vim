
"==============================================================
"          ColorScheme                                      {{{
"==============================================================

function! s:SetColorScheme()
  if has('syntax') && !exists('g:syntax_on')
    syntax on " シンタックスカラーリングオン
  endif
  set t_Co=256
  set background=dark
  let g:color_scheme = 'desert'
  execute 'colorscheme ' g:color_scheme
  colorscheme desert
  " ポップアップメニューの色変える
  highlight Pmenu ctermfg=Black ctermbg=Gray
  highlight PmenuSel ctermfg=Black ctermbg=Cyan
  highlight PmenuSbar ctermfg=White ctermbg=DarkGray
  highlight PmenuThumb ctermfg=DarkGray ctermbg=White
  set nocursorline
endfunction

call s:SetColorScheme()

" true color support
let colorterm=$COLORTERM
if colorterm=='truecolor' || colorterm=='24bit'
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

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

" }}}

