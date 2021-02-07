nnoremap sp :call print_debug#print_debug()<cr>
let g:print_debug_templates = {
      \   'go':              'fmt.Printf("+++ {}\n")',
      \   'python':          'print(f"+++ {}")',
      \   'javascript':      'console.log(`+++ {}`);',
      \   'typescript':      'console.log(`+++ {}`);',
      \   'typescriptreact': 'console.log(`+++ {}`);',
      \   'c':               'printf("+++ {}\n");',
      \   'rust':            'println!("+++ {}\n");',
      \   'sh':              'echo "+++ {}"',
      \   'zsh':             'echo "+++ {}"',
      \ }
