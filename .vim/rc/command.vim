
"==============================================================
"          command                                          {{{
"==============================================================

" CDC = Change to Directory of Current file
command! CDC lcd %:p:h

" Diff current buffer " :w !diff %-
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Toggle GitGutter/mark
command! LeftColumnToggle ALEToggle | GitGutterToggle | SignatureToggleSigns

" Change indent
command! -nargs=1 IndentChange set tabstop=<args> shiftwidth=<args>

function! ReloadEncoding(args)
  execute 'e ++enc=' . a:args
endfunction
command! -nargs=1 EncodingReload :call ReloadEncoding(<f-args>)

function! SetCmdLine(args)
  let s:input = input('', a:args)
  execute s:input
  call histadd('cmd', s:input)
endfunction

" delete blank lines
command! DeleteBlankLines :call SetCmdLine(':g/^$/d')
" count word
command! CountWord :call SetCmdLine(':%s/\<<C-r><C-w>\>/&/gn')

" open definition in preview window
command! PreviewDefinition :execute "normal \<C-w>}"

command! FullPath :echo expand("%:p")

" Spell Dictionary
command! AddCorrectSpell :execute "normal zg"
command! AddWrongSpell  :execute "normal zw"
command! ChangeCorrectSpell  :execute "normal z="

" Binary
command! BinaryModeOn :%!xxd -g1
command! BinaryModeOff :%!xxd -r
command! HexDumpOn :%!xxd -g1
command! HexDumpOff :%!xxd -r

" Trim whitespace
command! TrimWhiteSpace :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s
" command! TrimWhiteSpace :%s/\s\+$//e

" }}}

