"==============================================================
"               .vimrc
"==============================================================

"--------------------------------------------------------------
"          Initial Configuration                            {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/init.vim'))
  source ~/.vim/rc/init.vim
endif

" }}}


"--------------------------------------------------------------
"          Plugins                                          {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/pluginlist.vim'))
  source ~/.vim/rc/pluginlist.vim
endif

" }}}


"--------------------------------------------------------------
"          Base Configuration                               {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/base.vim'))
  source ~/.vim/rc/base.vim
endif

" }}}


"--------------------------------------------------------------
"         Layout Settings                                   {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/display.vim'))
  source ~/.vim/rc/display.vim
endif

if filereadable(expand('~/.vim/rc/statusline.vim'))
  source ~/.vim/rc/statusline.vim
endif

if filereadable(expand('~/.vim/rc/coloring.vim'))
  source ~/.vim/rc/coloring.vim
endif

" }}}


"--------------------------------------------------------------
"          Key mapping                                      {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/mappings.vim'))
  source ~/.vim/rc/mappings.vim
endif

" }}}


"--------------------------------------------------------------
"          command                                          {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/command.vim'))
  source ~/.vim/rc/command.vim
endif

" }}}


"--------------------------------------------------------------
"          Special Configuration                            {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/plugin/lastposition.vim'))
  source ~/.vim/rc/plugin/lastposition.vim
endif

if filereadable(expand('~/.vim/rc/plugin/persistentundo.vim'))
  source ~/.vim/rc/plugin/persistentundo.vim
endif

if filereadable(expand('~/.vim/rc/plugin/autopaste.vim'))
  source ~/.vim/rc/plugin/autopaste.vim
endif

if filereadable(expand('~/.vim/rc/plugin/mouse.vim'))
  source ~/.vim/rc/plugin/mouse.vim
endif

" }}}


"--------------------------------------------------------------
"          Plugin Settings                                  {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vim/rc/pluginconfig.vim'))
  source ~/.vim/rc/pluginconfig.vim
endif

" }}}


"--------------------------------------------------------------
"          Local Configuration                              {{{
"--------------------------------------------------------------

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" }}}


