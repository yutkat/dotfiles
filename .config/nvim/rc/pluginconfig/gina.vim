call gina#custom#command#option('status', '--short')
call gina#custom#command#option(
      \ '/\%(branch\|changes\|grep\|log\|blame\|chaperon\|commit\|compare\|diff\|edit\|ls\|patch\|show\|stash\|status\|tag\)',
      \ '--opener', 'tabedit'
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'c',
      \ '<Cmd>tabclose \| Gina commit<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)

call gina#custom#mapping#nmap(
      \ 'commit', 's',
      \ '<Cmd>tabclose \| Gina status<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)

nnoremap <git>s <Cmd>Gina status<CR>
