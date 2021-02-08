function! RefDoc() abort
  if &filetype =~? 'perl'
    execute 'Ref perldoc'
  elseif &filetype =~? 'python'
    execute 'Ref pydoc'
  elseif &filetype =~? 'ruby'
    execute 'Ref refe'
  elseif &filetype =~? 'cpp'
    if has('nvim')
      execute 'terminal cppman ' .expand('<cword>')
    else
      execute '!cppman ' .expand('<cword>')
    endif
  elseif &filetype =~? 'go'
    execute 'GoDoc'
  else
    execute 'Ref man'
  endif
endfunction
map <F1> <Cmd>call RefDoc()<CR>

let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
let g:ref_lynx_use_cache = 1

let g:ref_source_webdict_sites = {
      \   'weblio' : {
      \     'url' : 'https://ejje.weblio.jp/content/%s'
      \   },
      \   'wikij': {
      \     'url': 'https://ja.wikipedia.org/wiki/%s',
      \   },
      \   'wiki': {
      \     'url': 'https://en.wikipedia.org/wiki/%s',
      \   },
      \   'github': {
      \     'url': 'https://github.com/%s',
      \   },
      \   'github_raw': {
      \     'url': 'https://raw.githubusercontent.com/%s',
      \   },
      \   'docs_rs': {
      \     'url': 'https://docs.rs/%s',
      \   },
      \   'crates_io': {
      \     'url': 'https://crates.io/search?q=%s',
      \   },
      \ }
function! g:ref_source_webdict_sites.weblio.filter(output) abort
  return join(split(a:output, "\n")[24 :], "\n")
endfunction

function! g:ref_source_webdict_sites.wiki.filter(output) abort
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

function! g:ref_source_webdict_sites.docs_rs.filter(output) abort
  return join(split(a:output, "\n")[14 :], "\n")
endfunction

function! g:ref_source_webdict_sites.crates_io.filter(output) abort
  return join(split(a:output, "\n")[14 :], "\n")
endfunction

let g:ref_source_webdict_sites.default = 'weblio'
nnoremap <silent><expr> <Leader>re ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
vnoremap <silent> <Leader>re "zy:Ref webdict weblio <C-r>"<CR>
nnoremap <silent><expr> <Leader>rwj ':Ref webdict wikij ' . expand('<cword>') . '<CR>'
vnoremap <silent> <Leader>rwj "zy:Ref webdict wikij <C-r>"<CR>
nnoremap <silent><expr> <Leader>rw ':Ref webdict wiki ' . expand('<cword>') . '<CR>'
vnoremap <silent> <Leader>rw "zy:Ref webdict wiki <C-r>"<CR>

nnoremap <silent><expr> <S-F1> ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
vnoremap <silent> <S-F1> "zy:Ref webdict weblio <C-r>"<CR>
nnoremap <silent><expr> <C-F1> ':Ref webdict wiki ' . expand('<cword>') . '<CR>'

command! WeblioCurrentWord execute 'Ref webdict weblio ' . expand('<cword>')
command! -nargs=1 Weblioj execute 'Ref webdict weblio ' '<args>'
command! -nargs=1 Weblioe execute 'Ref webdict weblio ' '<args>'
command! Wikij execute 'Ref webdict wikij ' . expand('<cword>')
command! Wiki execute 'Ref webdict wiki ' . expand('<cword>')

" GitHub
command! GitHubReadMe execute 'Ref webdict github_raw ' . expand('<cWORD>')[1:-2] . '/master/README.md'

" Rust
command! RustDocsCurrentWord execute 'Ref webdict docs_rs ' . expand('<cword>')
command! -nargs=1 RustDocs execute 'Ref webdict docs_rs ' '<args>'
" don't work because this site requires javascript
" command! RustCratesIOCurrentWord execute 'Ref webdict crates_io ' . expand('<cword>')
" command! -nargs=1 RustCratesIO execute 'Ref webdict crates_io ' '<args>'
