"==============================================================
"               Util Functions
"==============================================================

function! vimrc#source_safe(file)
  if filereadable(expand(a:file))
    execute 'source ' . a:file
  endif
endfunction

function! vimrc#is_supported_truecolor() abort
  if (
        \ (has('termtruecolor') && &guicolors == 1) ||
        \ (has('termguicolors') && &termguicolors == 1) ||
        \ (exists('$NVIM_TUI_ENABLE_TRUE_COLOR') && !exists('+termguicolors'))
        \ )
    return v:true
  else
    return v:false
  endif
endfunction

function! vimrc#is_dir(dir) abort
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction

function! vimrc#is_normal_buffer() abort
  if &ft ==? 'qf' ||
        \ &ft ==? 'Vista' ||
        \ &ft ==? 'coc-explorer'
    return v:false
  endif

  if empty(&buftype) ||
        \ &ft ==? 'diff' " for gina diff
    return v:true
  endif

  return v:true
endfunction


