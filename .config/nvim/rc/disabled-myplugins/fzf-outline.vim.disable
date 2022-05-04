if exists('g:loaded_fzf_outline')
  finish
endif
let g:loaded_fzf_outline = 1


function! s:outline_format(lists) abort
  for list in a:lists
    let linenr = list[2][:len(list[2])-3]
    let line = getline(linenr)
    let idx = stridx(line, list[0])
    let len = len(list[0])
    let list[0] = line[: idx-1] . printf("\x1b[%s%sm%s\x1b[m", 34, '', line[idx : idx+len-1]) . line[idx+len :]
  endfor
  for list in a:lists
    call map(list, "printf('%s', v:val)")
  endfor
  return a:lists
endfunction

function! s:outline_source(tag_cmds) abort
  if !filereadable(expand('%'))
    throw 'Save the file first'
  endif

  for cmd in a:tag_cmds
    let lines = split(system(cmd), "\n")
    if !v:shell_error
      break
    endif
  endfor
  if v:shell_error
    throw get(lines, 0, 'Failed to extract tags')
  elseif empty(lines)
    throw 'No tags found'
  endif
  return map(s:outline_format(map(lines, 'split(v:val, "\t")')), 'join(v:val, "\t")')
endfunction

function! s:outline_sink(lines) abort
  if !empty(a:lines)
    let line = a:lines[0]
    execute split(line, "\t")[2]
  endif
endfunction

function! s:outline(...) abort
  let args = copy(a:000)
  let tag_cmds = [
    \ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s 2>/dev/null', &filetype, expand('%:S')),
    \ printf('ctags -f - --sort=no --excmd=number %s 2>/dev/null', expand('%:S'))]
  return {
    \ 'source':  s:outline_source(tag_cmds),
    \ 'sink*':   function('s:outline_sink'),
    \ 'options': '--reverse +m -d "\t" --with-nth 1 -n 1 --ansi --prompt "Outline> "'}
endfunction

command! -bang Outline call fzf#run(fzf#wrap('outline', s:outline(), <bang>0))
