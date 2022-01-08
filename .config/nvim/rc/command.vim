"==============================================================
"          command
"==============================================================

command! Terminals sp | terminal
command! Terminalv vs | terminal

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
command! DelMarks delmarks! | wshada!

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
  execute 'edit ' .. resolve(expand(stdpath('config') .. '/rc/pluginconfig/')) .. '/' .. fnamemodify(plugin_name, ":r") .. '.vim'
endfunction
function! EditPluginConfigLua() abort
  let plugin_name = s:get_plugin_name()
  execute 'edit ' .. resolve(expand(stdpath('config') .. '/lua/rc/pluginconfig/')) .. '/' .. fnamemodify(plugin_name, ":r") .. '.lua'
endfunction
command! EditPluginConfigVim call EditPluginConfigVim()
command! EditPluginConfigLua call EditPluginConfigLua()

" profile
command! Profile profile start /tmp/vim-profile.log | profile func * | profile file *

command! DeleteHiddenBuffers call DeleteHiddenBuffers()
function! DeleteHiddenBuffers()
  let l:tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
  for s:buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
    silent execute 'bwipeout! ' s:buf
  endfor
endfunction

command! DeleteEmptyBuffers call DeleteEmptyBuffers()
function! DeleteEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
    execute 'bwipeout! ' . join(buffers, ' ')
  endif
endfunction

" tab buffer window list
" https://koturn.hatenablog.com/entry/2018/02/13/000000
function! s:create_winid2bufnr_dict() abort
  let winid2bufnr_dict = {}
  for bnr in filter(range(1, bufnr('$')), 'v:val')
    for wid in win_findbuf(bnr)
      let winid2bufnr_dict[wid] = bnr
    endfor
  endfor
  return winid2bufnr_dict
endfunction

function! s:show_tab_info() abort
  echo "====== Tab Page Info ======"
  let current_tnr = tabpagenr()
  let winid2bufnr_dict = s:create_winid2bufnr_dict()
  for tnr in range(1, tabpagenr('$'))
    let current_winnr = tabpagewinnr(tnr)
    echo (tnr == current_tnr ? '>' : ' ') 'Tab:' tnr
    echo '    Buffer number | Window Number | Window ID | Buffer Name'
    for wininfo in map(map(range(1, tabpagewinnr(tnr, '$')), '{"wnr": v:val, "wid": win_getid(v:val, tnr)}'), 'extend(v:val, {"bnr": winid2bufnr_dict[v:val.wid]})')
      echo '   ' (wininfo.wnr == current_winnr ? '*' : ' ') printf('%11d | %13d | %9d | %s', wininfo.bnr, wininfo.wnr, wininfo.wid, bufname(wininfo.bnr))
    endfor
  endfor
endfunction
command! -bar TabInfo call s:show_tab_info()
