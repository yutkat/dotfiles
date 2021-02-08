let g:dashboard_default_executive ='telescope'

if filereadable(expand('~/.config/nvim/rc/files/dashboard_custom_header.txt'))
  let g:dashboard_custom_header = readfile(expand('~/.config/nvim/rc/files/dashboard_custom_header.txt'))
endif
augroup vimrc_dashboard-nvim
autocmd!
autocmd VimLeavePre * SessionSave
augroup END

