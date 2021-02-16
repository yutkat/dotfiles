
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
command! -range=% SelectedInfo normal! gvg<C-g>

" open definition in preview window
command! PreviewDefinition normal! <C-w>}

" Spell Dictionary
command! AddCorrectSpell normal! zg
command! AddWrongSpell  normal! zw
command! ChangeCorrectSpell normal! z=
command! FixCorrectSpell ChangeCorrectSpell
command! CorrectSpell ChangeCorrectSpell

" Binary
command! BinaryModeOn %!xxd -g1
command! BinaryModeOff %!xxd -r
command! HexDumpOn %!xxd -g1
command! HexDumpOff %!xxd -r

" Trim whitespace
command! TrimWhiteSpace keeppatterns %s/\s\+$//e <Bar> :nohlsearch
" command! TrimWhiteSpace %s/\s\+$//e

" Spell check
command! SpellCheckOff setlocal nospell
command! SpellCheckOn  setlocal spell! spelllang=en_us

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
function! s:get_plugin_name() abort
  let plugin_repo = matchstr(expand('<cWORD>'), "['\"].*/.*['\"]")[1:-2]
  return split(plugin_repo, '/')[1]
endfunction
function! EditPluginConfigVim() abort
  let plugin_name = s:get_plugin_name()
  execute 'edit ' .. stdpath('config') .. '/rc/pluginconfig/' .. fnamemodify(plugin_name, ":r") .. '.vim'
endfunction
function! EditPluginConfigLua() abort
  let plugin_name = s:get_plugin_name()
  execute 'edit ' .. stdpath('config') .. '/lua/rc/pluginconfig/' .. fnamemodify(plugin_name, ":r") .. '.lua'
endfunction
command! EditPluginConfigVim call EditPluginConfigVim()
command! EditPluginConfigLua call EditPluginConfigLua()


" }}}

