
"==============================================================
"          command                                          {{{
"==============================================================

" CDC = Change to Directory of Current file
command! CdCurrentDirectory lcd %:p:h

" Diff current buffer " :w !diff %-
if !exists(':DiffOrig')
  command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

command! SetNumberToggle set number! relativenumber!

" Change indent
command! -nargs=1 IndentChange set tabstop=<args> shiftwidth=<args>

function! ReloadEncoding(args) abort
  execute 'e ++enc=' . a:args
endfunction
command! -nargs=1 EncodingReload call ReloadEncoding(<f-args>)

function! SetCmdLine(args) abort
  let l:input = input('', a:args)
  execute l:input
  call histadd('cmd', l:input)
endfunction

" delete blank lines
command! DeleteBlankLines call SetCmdLine(':g/^$/d')
" count word
command! CountWord call SetCmdLine(':%s/\<<C-r><C-w>\>/&/gn')
command! -range=% SelectedInfo call feedkeys("gvg\<C-g>")

" open definition in preview window
command! PreviewDefinition execute "normal! \<C-w>}"

" Spell Dictionary
command! AddCorrectSpell execute "normal! zg"
command! AddWrongSpell  execute "normal! zw"
command! ChangeCorrectSpell  execute ':call feedkeys("z=")'
command! FixCorrectSpell  execute ':ChangeCorrectSpell'
command! CorrectSpell  execute ':ChangeCorrectSpell'

" Binary
command! BinaryModeOn %!xxd -g1
command! BinaryModeOff %!xxd -r
command! HexDumpOn %!xxd -g1
command! HexDumpOff %!xxd -r

" Trim whitespace
command! TrimWhiteSpace let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s
" command! TrimWhiteSpace %s/\s\+$//e

" Spell check
command! SpellCheckOff execute "setlocal nospell"
command! SpellCheckOn  execute "setlocal spell! spelllang=en_us"

" Nvim delmark
if has('nvim')
  command! DelMarks delmarks! | wshada!
endif

" sort startuptime
command! SortStartupTime %!sort -k2nr

" json
command! JsonDemangle %!jq '.'

" q record
command! -nargs=1 Recording normal! q<args>

" file fullpath
command! Filepath echo expand('%:p')
command! FileWithNumber echo join([expand('%'),  line(".")], ':')

" edit plugin config
function! EditPluginConfig(plugin_name) abort
  edit $HOME/.vim/rc/pluginconfig.vim
  let l:num = search('" ' . a:plugin_name)
  if l:num == 0
    call search('" ---$')
    execute 'normal 4k'
    call setreg('+', a:plugin_name)
  endif
endfunction
command! EditPluginConfig call EditPluginConfig(split(expand('<cWORD>')[1:-2], '/')[1])


" }}}

