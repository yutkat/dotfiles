
"==============================================================
"          ColorScheme                                      {{{
"==============================================================

function! s:SetColorScheme()
  if has('syntax') && !exists('g:syntax_on')
    syntax on " シンタックスカラーリングオン
  endif
  set t_Co=256
  set background=dark
  try
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
    let g:color_scheme = 'hybrid'
    execute 'colorscheme ' g:color_scheme
  catch /^Vim\%((\a\+)\)\=:E185/
    let g:color_scheme = 'desert'
    execute 'colorscheme ' g:color_scheme
    colorscheme desert
    " ポップアップメニューの色変える
    highlight Pmenu ctermfg=Black ctermbg=Gray
    highlight PmenuSel ctermfg=Black ctermbg=Cyan
    highlight PmenuSbar ctermfg=White ctermbg=DarkGray
    highlight PmenuThumb ctermfg=DarkGray ctermbg=White
  endtry
  set nocursorline
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

" }}}

