call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
" nnoremap <expr> <Leader>w wilder#toggle()
command! WilderToggle call wilder#toggle()

" call wilder#disable()

" only / and ? is enabled by default
" call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('modes', [':'])

" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#cmdline_pipeline({
"       \       'fuzzy': 1,
"       \       'use_python': 1,
"       \     }),
"       \     wilder#python_search_pipeline({
"       \       'regex': 'fuzzy',
"       \       'engine': 're',
"       \       'sort': wilder#python_sorter_difflib(),
"       \     }),
"       \   ),
"       \ ])
" call wilder#set_option('renderer', wilder#wildmenu_renderer({
"       \ 'highlights': {
"       \   'default': s:hl,
"       \ },
"       \ 'apply_highlights': wilder#query_common_subsequence_spans(),
"       \ 'separator': '  ',
"       \ 'left': [{'value': [
"       \    wilder#condition(
"       \      {-> getcmdtype() ==# ':'},
"       \      ' COMMAND ',
"       \      ' SEARCH ',
"       \    ),
"       \    wilder#condition(
"       \      {ctx, x -> has_key(ctx, 'error')},
"       \      '!',
"       \      wilder#spinner({
"       \        'frames': '-\|/',
"       \        'done': '',
"       \      }),
"       \    ), ' ',
"       \ ], 'hl': s:mode_hl,},
"       \ wilder#separator('', s:mode_hl, s:hl, 'left'), ' ',
"       \ ],
"       \ 'right': [
"       \    ' ', wilder#separator('', s:index_hl, s:hl, 'right'),
"       \    wilder#index({'hl': s:index_hl}),
"       \ ],
"       \ }))
