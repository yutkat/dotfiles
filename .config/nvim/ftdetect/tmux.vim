function! s:DetectShebang(default_type) abort
  let shebang_type = expand(fnamemodify(matchstr(getline(1),  '^#!\s*\zs.*$'), ':t'))
  if empty(shebang_type)
    execute "set filetype=" . a:default_type
  else
    if shebang_type =~# "env.*"
      let shebang_type_splitted = split(shebang_type, ' ')
      if shebang_type_splitted[1] ==# "bash"
        set filetype=sh
      else
        execute "set filetype=" . shebang_type_splitted[1]
      endif
    else
      execute "set filetype=" . shebang_type
    endif
  endif
endfunction

autocmd BufRead,BufNewFile *.tmux call s:DetectShebang('tmux')
