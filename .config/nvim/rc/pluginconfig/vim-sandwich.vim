" use mappings sa, sd, sr
xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)
xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

if IsPluginInstalled('vim-textobj-functioncall')
  let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
  " ycino's generics
  let g:sandwich#recipes += [
        \ {
        \   'buns': ['InputGenerics()', '">"'],
        \   'expr': 1,
        \   'cursor': 'inner_tail',
        \   'kind': ['add', 'replace'],
        \   'action': ['add'],
        \   'input': ['g']
        \ },
        \ {
        \   'external': ['i<', "\<Plug>(textobj-functioncall-a)"],
        \   'noremap': 0,
        \   'kind': ['delete', 'replace', 'query'],
        \   'input': ['g']
        \ },
        \ ]
  function! InputGenerics() abort
    let genericsname = input('Generics Name: ', '')
    if genericsname ==# ''
      throw 'OperatorSandwichCancel'
    endif
    return genericsname . '<'
  endfunction
endif
