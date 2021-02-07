" Change only current window's directory
let g:rooter_cd_cmd='lcd'
" To stop vim-rooter changing directory automatically
let g:rooter_manual_only = 1
" files/directories for the root directory
let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
" Automatically change the directory
"autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
