call gina#custom#command#option('status', '--short')
call gina#custom#command#option(
      \ '/\%(branch\|changes\|grep\|log\|blame\|chaperon\|commit\|compare\|diff\|edit\|ls\|patch\|show\|stash\|status\|tag\)',
      \ '--opener', 'tabedit'
      \)
