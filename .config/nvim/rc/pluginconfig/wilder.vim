call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
" nnoremap <expr> <Leader>w wilder#toggle()
command! WilderToggle call wilder#toggle()

" call wilder#disable()

" only / and ? is enabled by default
call wilder#set_option('modes', ['/', '?', ':'])
let s:hl = 'LightlineMiddle_active'
let s:mode_hl = 'LightlineLeft_active_0'
let s:index_hl = 'LightlineRight_active_0'

function! FilterCocList(ctx, res) abort
  let l:parsed = wilder#cmdline#parse(a:ctx.input)
  if l:parsed.cmd ==# 'CocList'
    let l:arg = l:parsed.cmdline[l:parsed.pos :]
    return extend(a:res, {
          \ 'value': filter(a:res.value, {i, x -> match(x, l:arg) != -1}),
          \ 'data': extend(get(a:res, 'data', {}), {'query': l:arg})
          \ })
  endif
  return a:res
endfunction

call wilder#set_option('pipeline', wilder#branch(
      \ wilder#python_search_pipeline(),
      \ wilder#cmdline_pipeline() + [funcref('FilterCocList')]
      \ ))
" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     [
"       \       wilder#check({_, x -> empty(x)}),
"       \       wilder#history(),
"       \     ],
"       \     wilder#vim_search_pipeline(),
"       \     wilder#cmdline_pipeline({
"       \       'fuzzy': 1,
"       \       'use_python': 1,
"       \     }),
"       \     wilder#python_search_pipeline({
"       \       'regex': 'fuzzy',
"       \       'engine': 're',
"       \       'sort': function('wilder#python_sort_difflib'),
"       \     }),
"       \   ),
"       \ ])
call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlights': {
      \   'default': s:hl,
      \ },
      \ 'apply_highlights': wilder#query_common_subsequence_spans(),
      \ 'separator': '  ',
      \ 'left': [{'value': [
      \    wilder#condition(
      \      {-> getcmdtype() ==# ':'},
      \      ' COMMAND ',
      \      ' SEARCH ',
      \    ),
      \    wilder#condition(
      \      {ctx, x -> has_key(ctx, 'error')},
      \      '!',
      \      wilder#spinner({
      \        'frames': '-\|/',
      \        'done': '',
      \      }),
      \    ), ' ',
      \ ], 'hl': s:mode_hl,},
      \ wilder#separator('', s:mode_hl, s:hl, 'left'), ' ',
      \ ],
      \ 'right': [
      \    ' ', wilder#separator('', s:index_hl, s:hl, 'right'),
      \    wilder#index({'hl': s:index_hl}),
      \ ],
      \ }))
