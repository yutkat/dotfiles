if filereadable(expand('~/.config/nvim/rc/files/startify_custom_header.txt'))
  let g:startify_custom_header = startify#fortune#boxed() +
        \ readfile(expand('~/.config/nvim/rc/files/startify_custom_header.txt'))
endif
let g:startify_custom_footer = ['', '                                 powered by vim-startify', '']
let g:startify_session_dir = expand('~/.local/share/nvim/sessions')
call mkdir(g:startify_session_dir, 'p')
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1

let g:startify_commands = [
      \ {'m': ['Memo', 'MemoNew tmp']},
      \ {'l': ['MemoList', 'MemoListSort']},
      \ {'i': ['PlugInstall', 'PlugInstall']},
      \ {'u': ['PlugUpdate', 'PlugUpdate']},
      \ ]
