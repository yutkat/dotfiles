let g:dashboard_default_executive ='telescope'

if filereadable(expand('~/.config/nvim/rc/files/dashboard_custom_header.txt'))
  let g:dashboard_custom_header = readfile(expand('~/.config/nvim/rc/files/dashboard_custom_header.txt'))
endif

" let g:dashboard_custom_shortcut={
"       \ 'last_session'       : 'l',
"       \ 'find_history'       : 'h',
"       \ 'find_file'          : 'f',
"       \ 'new_file'           : 'n',
"       \ 'change_colorscheme' : 'c',
"       \ 'find_word'          : 'a',
"       \ 'book_marks'         : 'b',
"       \ }

let g:dashboard_custom_section={
      \   'last_session': {
      \     'description': [' Open last session        l'],
      \     'command': 'SessionLoad'
      \   },
      \   'my_find_history': {
      \     'description': [' Recently opened files    h'],
      \     'command': 'DashboardFindHistory'
      \   },
      \   'my_find_file': {
      \     'description': [' Find file                f'],
      \     'command': 'DashboardFindHistory'
      \   },
      \   'my_new_file': {
      \     'description': [' New file                 e'],
      \     'command': 'DashboardFindHistory'
      \   },
      \   'my_find_word': {
      \     'description': [' Find word                a'],
      \     'command': 'DashboardFindWord'
      \   },
      \   'my_book_marks': {
      \     'description': [' Jump to bookmarks        b'],
      \     'command': 'DashboardJumpMark'
      \   },
      \   'memo_new': {
      \     'description': [' Memo New                 n'],
      \     'command': 'MemoNew tmp'
      \   },
      \   'memo_list': {
      \     'description': [' Memo List                m'],
      \     'command': 'MemoListSort'
      \   }
      \ }

augroup vimrc_dashboard-nvim
  autocmd!
  autocmd FileType dashboard nnoremap <silent> <buffer> l <Cmd>SessionLoad<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> h <Cmd>DashboardFindHistory<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> f <Cmd>DashboardFindFile<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> e <Cmd>DashboardNewFile<CR>
  " autocmd FileType dashboard nnoremap <silent> <buffer> c <Cmd>DashboardChangeColorscheme<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> a <Cmd>DashboardFindWord<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> b <Cmd>DashboardJumpMark<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> n <Cmd>MemoNew tmp<CR>
  autocmd FileType dashboard nnoremap <silent> <buffer> m <Cmd>Telescope memo<CR>

  autocmd VimLeavePre * SessionSave
augroup END

