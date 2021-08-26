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
        \ &ft ==? 'coc-explorer' ||
        \ &ft ==? 'diff' " for gina diff
    return v:false
  endif

  if empty(&buftype) ||
        \ &buftype ==? 'terminal'
    return v:true
  endif

  return v:true
endfunction

function! vimrc#open_file_with_line_col(file, word) abort
  let l:f = findfile(a:file)
  let l:num = matchstr(a:word, a:file .. ':' .. '\zs\d*\ze')
  if !empty(f)
    wincmd p
    execute 'e ' . l:f
    if !empty(l:num)
      execute l:num
      let l:col = matchstr(a:word, a:file .. ':\d*:' .. '\zs\d*\ze')
      if !empty(l:col)
        execute 'normal! ' . l:col . '|'
      endif
    endif
  endif
endfunction

function! vimrc#go_to_file_from_terminal() abort
  let r = expand('<cfile>')
  if filereadable(expand(r))
    return r
  endif
  normal! j
  let r1 = expand('<cfile>')
  if filereadable(expand(r .. r1))
    return r .. r1
  endif
  normal! 2k
  let r2 = expand('<cfile>')
  if filereadable(expand(r2 .. r))
    return r2 .. r
  endif
  normal! j
  return r
endfunction
