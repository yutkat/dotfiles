"==============================================================
"               .vimrc
"==============================================================

function! SourceSafe(file)
  if filereadable(expand(a:file))
    execute "source " . a:file
  endif
endfunction


"--------------------------------------------------------------
"          Initial Configuration                            {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/init.vim')

" }}}


"--------------------------------------------------------------
"          Plugins                                          {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/pluginlist.vim')

" }}}


"--------------------------------------------------------------
"          Base Configuration                               {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/base.vim')

" }}}


"--------------------------------------------------------------
"         Layout Settings                                   {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/display.vim')
call SourceSafe('~/.vim/rc/statusline.vim')
call SourceSafe('~/.vim/rc/coloring.vim')

" }}}


"--------------------------------------------------------------
"          Key mapping                                      {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/mappings.vim')

" }}}


"--------------------------------------------------------------
"          command                                          {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/command.vim')

" }}}


"--------------------------------------------------------------
"          Special Configuration                            {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/plugin/lastposition.vim')
call SourceSafe('~/.vim/rc/plugin/persistentundo.vim')
call SourceSafe('~/.vim/rc/plugin/autopaste.vim')
call SourceSafe('~/.vim/rc/plugin/mouse.vim')

" }}}


"--------------------------------------------------------------
"          Plugin Settings                                  {{{
"--------------------------------------------------------------

call SourceSafe('~/.vim/rc/pluginconfig.vim')

" }}}


"--------------------------------------------------------------
"          Local Configuration                              {{{
"--------------------------------------------------------------

call SourceSafe('~/.vimrc.local')

" }}}


