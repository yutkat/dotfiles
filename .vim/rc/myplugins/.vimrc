"==============================================================
"               .vimrc
"==============================================================

function! SourceSafe(file)
  if filereadable(expand(a:file))
    execute 'source ' . a:file
  endif
endfunction


" Initial Configuration
source ~/.vim/rc/init.vim

" Functions
source ~/.vim/rc/function.vim

" Base Configuration
source ~/.vim/rc/base.vim
if has('nvim')
  source ~/.vim/rc/base.nvim
endif

" Layout Settings
source ~/.vim/rc/display.vim
source ~/.vim/rc/statusline.vim

" Plugins
source ~/.vim/rc/pluginlist.vim

" Key mapping
source ~/.vim/rc/keyconfig.vim
source ~/.vim/rc/mappings.vim

" Command
source ~/.vim/rc/command.vim
source ~/.vim/rc/autocmd.vim

" Configuration
for f in split(glob('~/.vim/rc/myplugins/*.vim'), '\n')
  execute "source " . f
endfor
if has('nvim')
  for f in split(glob('~/.vim/rc/myplugins/*.nvim'), '\n')
    execute "source " . f
  endfor
endif

" Plugin Settings
source ~/.vim/rc/pluginconfig.vim

" Local Configuration
call SourceSafe('~/.vimrc.local')

