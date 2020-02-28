"==============================================================
"               Util Functions
"==============================================================

function! IsSupportedTrueColor() abort
  if ((has('termtruecolor') && &guicolors == 1) ||
        \ (has('termguicolors') && &termguicolors == 1) ||
        \ (has('nvim') && exists('$NVIM_TUI_ENABLE_TRUE_COLOR')
        \ && !exists('+termguicolors')))
    return v:true
  else
    retrun v:false
  endif
endfunction
