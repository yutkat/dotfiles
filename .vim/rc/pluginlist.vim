
"==============================================================
"          Plugins                                          {{{
"==============================================================

" neocompleteの対応を確認する
function! s:meet_neocomplete_requirements()
  return has('lua') && (v:version > 703 || (v:version == 703
        \ && has('patch885')))
endfunction

if !((has('python') || has('python3') || has('ruby') || has('nvim'))
      \ && v:version > 703)
  echo 'Not load a plugin. Required +python/+python3/+ruby support or nvim'
  finish
endif


if has('vim_starting')
  let s:pluin_manager_dir='~/.vim/plugged/vim-plug'
  execute 'set runtimepath+=' . s:pluin_manager_dir
  if !isdirectory(expand(s:pluin_manager_dir))
    call system('mkdir -p ' . s:pluin_manager_dir)
    call system('git clone --depth 1 https://github.com/junegunn/vim-plug.git '
        \ . s:pluin_manager_dir . '/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug',
      \ {'dir': '~/.vim/plugged/vim-plug/autoload'}


"------------------------------------------------------------
" Common

"------------------------------
" Move
Plug 'Lokaltog/vim-easymotion'
Plug 'rhysd/clever-f.vim'
if !has('nvim')
  Plug 'osyo-manga/vim-milfeulle'
else
  Plug 'vim-scripts/ingo-library'
  Plug 'vim-scripts/EnhancedJumps'
endif
Plug 'justinmk/vim-ipmotion'
Plug 'vim-scripts/camelcasemotion'
Plug 'rhysd/accelerated-jk'
Plug 'haya14busa/vim-edgemotion'

"------------------------------
" Key Bind
Plug 'tpope/vim-rsi'
Plug 'kana/vim-smartchr'

"------------------------------
" Window
Plug 't9md/vim-choosewin'
Plug 'blueyed/vim-diminactive'
Plug 'osyo-manga/vim-automatic'

"------------------------------
" Select
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'

"------------------------------
" Search
if !has('nvim')
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
endif
" because dislike the autoclear
" if ((v:version == 800 && has('patch1238')) || v:version >= 801)
"   Plug 'haya14busa/is.vim'
" endif
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-over'
Plug 'osyo-manga/vim-anzu'
Plug 'osyo-manga/vim-hopping'
Plug 't9md/vim-quickhl'
Plug 'osyo-manga/vim-brightest', {
      \   'on': [ 'BrightestEnable', 'BrightestToggle' ]
      \ }
Plug 'wincent/ferret'

"------------------------------
" Replace
Plug 'tpope/vim-abolish'

"------------------------------
" Yank
Plug 'LeafCage/yankround.vim'
Plug 'haya14busa/vim-operator-flashy'
" depend 'kana/vim-operator-user'

"------------------------------
" Undo
Plug 'mbbill/undotree'

"------------------------------
" Buffer
"Plug 'jlanzarotta/bufexplorer' " -> can't open split window
Plug 'jeetsukumaran/vim-buffergator'
Plug 'ap/vim-buftabline'
Plug 'schickling/vim-bufonly'
Plug 'moll/vim-bbye'

"------------------------------
" Hex
Plug 'Shougo/vinarise.vim'

"------------------------------
" Grep tool
Plug 'vim-scripts/grep.vim'

"------------------------------
" Command
Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/CmdlineComplete'

"------------------------------
" File
Plug 'justinmk/vim-dirvish'
Plug 'scrooloose/nerdtree', {
      \   'on': ['NERDTree', 'NERDTreeToggle'],
      \ }
Plug 'yegappan/mru' " ファイル編集履歴リスト

"------------------------------
" Edit
Plug 'junegunn/vim-easy-align', {
      \   'on': ['EasyAlign'],
      \ }

"---------------
" Join
Plug 'AndrewRadev/splitjoin.vim'
Plug 'osyo-manga/vim-jplus'

"---------------
" Adding and subtracting
Plug 'osyo-manga/vim-trip'

"------------------------------
" Diff
Plug 'AndrewRadev/linediff.vim'

"------------------------------
" Map
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-unimpaired'

"------------------------------
" Tab
Plug 'kana/vim-tabpagecd'
"Plug 'taohex/lightline-buffer' " -> 今後に期待

"------------------------------
" Man
Plug 'thinca/vim-ref'

"------------------------------
" Font
"Plug 'ryanoasis/vim-devicons' " -> Mojibake

"------------------------------
" Session
"Plug 'xolox/vim-session'
"depend 'xolox/vim-misc'
"Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'

"------------------------------
" ColorScheme
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'tomasr/molokai'
"Plug 'nanotech/jellybeans.vim'

"------------------------------
" Statusline
Plug 'itchyny/lightline.vim'

"------------------------------
" Layout
Plug 'myusuf3/numbers.vim'

"------------------------------
" Text Object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-datetime'
Plug 'lucapette/vim-textobj-underscore'
Plug 'sgur/vim-textobj-parameter'
Plug 'mattn/vim-textobj-url'

"------------------------------
" Operator
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'emonkak/vim-operator-comment'
Plug 'emonkak/vim-operator-sort'
Plug 'tyru/operator-camelize.vim'
Plug 'rhysd/vim-operator-surround'

"------------------------------
" Terminal
if has('nvim')
  Plug 'kassio/neoterm'
endif

"------------------------------
" Util
Plug 'tyru/open-browser.vim'
Plug 'glidenote/memolist.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'dhruvasagar/vim-table-mode'

"------------------------------
" Library
Plug 'tpope/vim-repeat'
Plug 'mattn/webapi-vim'

"------------------------------
" etc
Plug 'thinca/vim-scouter', {
      \   'on': [ 'Scouter' ]
      \ }


"------------------------------------------------------------
" FuzzyFinders

"------------------------------
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'


"------------------------------------------------------------
" Coding

"------------------------------
" Syntax
Plug 'idanarye/vim-vebugger'
Plug 'sheerun/vim-polyglot'

"------------------------------
" Writing assistant
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'

"------------------------------
" Brackets
Plug 'kien/rainbow_parentheses.vim'
Plug 'cohama/lexima.vim'

"------------------------------
" Reading assistant
Plug 'vim-scripts/autopreview'
Plug 'Yggdroot/indentLine'

"------------------------------
" Code jump
Plug 'majutsushi/tagbar'
Plug 'kana/vim-altr'
if (v:version == 704 && has('patch786')) || v:version >= 705
  let g:loaded_matchparen = 1 | Plug 'itchyny/vim-parenmatch'
endif

"------------------------------
" Task runner
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
" Plug 'skywind3000/asyncrun.vim'

" Plug 'thinca/vim-quickrun'
" Plug 'dannyob/quickfixstatus'
" Plug 'KazuakiM/vim-qfstatusline'
" Plug 'osyo-manga/shabadou.vim'

"------------------------------
" Lint
if ((v:version == 800 && has('patch27')) || v:version >= 801)
      \ || has('nvim')
  Plug 'w0rp/ale'
  " Plug 'neomake/neomake' " -> ale
else
  Plug 'Shougo/vimproc.vim', {
        \   'do': 'make',
        \ }
  Plug 'osyo-manga/vim-watchdogs'
  Plug 'cohama/vim-hier'
  Plug 'KazuakiM/vim-qfsigns'
  "depend 'Shougo/vimproc.vim'
  "depend 'thinca/vim-quickrun'
  "depend 'osyo-manga/shabadou.vim'
  "depend 'KazuakiM/vim-qfsigns'
  "depend 'dannyob/quickfixstatus'
  "depend 'KazuakiM/vim-qfstatusline'
  "depend 'cohama/vim-hier'
endif

"------------------------------
" Snippet
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'mattn/sonictemplate-vim'

"------------------------------
" Completion
let s:deoplete_enable = 0
if has('nvim') && has('python3')
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'roxma/nvim-completion-manager' " -> deoplete
  let s:deoplete_enable = 1
elseif (v:version == 800) && (has('python3') || has('python')) &&
      \ ((stridx(execute('version'), '+python3/dyn') == -1) ||
      \  (stridx(execute('version'), '+python/dyn') == -1))
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  let s:deoplete_enable = 1
elseif (v:version == 800) && (has('python3') || has('python'))
  Plug 'maralla/completor.vim'
else
  if s:meet_neocomplete_requirements()
    Plug 'Shougo/neocomplete.vim'
  else
    Plug 'Shougo/neocomplcache.vim'
  endif
endif
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neoinclude.vim'

"------------------------------
" Project
Plug 'airblade/vim-rooter'
Plug 'embear/vim-localvimrc'

"------------------------------
" Git
if matchstr(system('git --version'), '\%(\d\.\)\+\d') >= 1.9
  if has('nvim') || ((v:version == 800 && has('patch27')) || v:version >= 801)
    Plug 'lambdalisue/gina.vim'
  endif
endif
Plug 'tpope/vim-fugitive'
Plug 'mattn/gist-vim'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'idanarye/vim-merginal'
Plug 'rhysd/committia.vim'


"------------------------------------------------------------
" Programing Languages

"------------------------------
" Clang
if (s:deoplete_enable == 1)
  " Plug 'zchee/deoplete-clang', {
  "       \   'for': ['c', 'cpp'],
  "       \ }
else
  Plug 'justmao945/vim-clang', {
        \   'for': ['c', 'cpp'],
        \ }
endif
Plug 'rhysd/vim-clang-format', {
      \   'for': ['c', 'cpp', 'objc']
      \ }
Plug 'octol/vim-cpp-enhanced-highlight', {
      \   'for': ['c', 'cpp', 'objc']
      \ }
Plug 'vim-scripts/gtags.vim', {
      \   'for': ['c', 'cpp', 'java'],
      \ }
if has('nvim')
  Plug 'critiqjo/lldb.nvim', {
        \   'for': ['c', 'cpp'],
        \   'do': ':UpdateRemotePlugins'
        \ }
endif

"------------------------------
" Java
" Plug 'google/ijaas', {
"       \   'rtp': 'vim',
"       \   'for': ['c', 'cpp', 'java'],
"       \ }

"------------------------------
" Groovy
Plug 'thecodesmith/vim-groovy', {
      \   'for': ['groovy'],
      \ }
Plug 'tfnico/vim-gradle', {
      \   'for': ['groovy'],
      \ }

"------------------------------
" HTML
Plug 'mattn/emmet-vim', {
      \   'for': ['html']
      \ }
Plug 'othree/html5.vim', {
      \   'for': ['html']
      \ }
Plug 'hokaccha/vim-html5validator', {
      \   'for': ['html']
      \ }
Plug 'elzr/vim-json', {
      \   'for': ['html']
      \ }

"------------------------------
" CSS
Plug 'hail2u/vim-css3-syntax', {
      \   'for': ['css']
      \ }
Plug 'groenewege/vim-less', {
      \   'for': ['css']
      \ }

"------------------------------
" Javascript
Plug 'pangloss/vim-javascript', {
      \   'for': ['javascript']
      \ }
Plug 'ternjs/tern_for_vim', {
      \   'for': ['javascript']
      \ }
Plug 'kchmck/vim-coffee-script', {
      \   'for': ['coffee']
      \ }
Plug 'leafgarland/typescript-vim', {
      \   'for': ['typescript']
      \ }
if (s:deoplete_enable == 1)
  Plug 'carlitux/deoplete-ternjs'
  ", { 'do': 'npm install -g tern' }
  Plug 'mhartington/deoplete-typescript', {
        \   'for': ['typescript']
        \ }
endif

"------------------------------
" Vue
Plug 'posva/vim-vue', {
      \   'for': ['vue']
      \ }

"------------------------------
" Riot
Plug 'ryym/vim-riot', {
      \   'for': ['riot']
      \ }

"------------------------------
" Python
Plug 'klen/python-mode', {
      \   'for': ['python']
      \ }
if (s:deoplete_enable == 1)
  Plug 'zchee/deoplete-jedi', {
        \   'for': ['python']
        \ }
else
  Plug 'davidhalter/jedi-vim', {
        \   'for': ['python']
        \ }
endif
Plug 'andviro/flake8-vim', {
      \   'for': ['python']
      \ }
Plug 'hynek/vim-python-pep8-indent', {
      \   'for': ['python']
      \ }

"------------------------------
" Ruby
Plug 'tpope/vim-rails', {
      \   'for': ['ruby']
      \ }
Plug 'thoughtbot/vim-rspec', {
      \   'for': ['ruby']
      \ }
Plug 'tpope/vim-endwise', {
      \   'for': ['ruby']
      \ }

"------------------------------
" PHP
Plug 'violetyk/cake.vim', {
      \   'for': ['php']
      \ }

"------------------------------
" Go
Plug 'fatih/vim-go', {
      \   'for': ['go']
      \ }
if (s:deoplete_enable == 1)
  Plug 'zchee/deoplete-go', {
        \   'for': ['go'],
        \   'do': 'make'
        \ }
endif

"------------------------------
" Rust
Plug 'rust-lang/rust.vim', {
      \   'for': ['rust']
      \ }
" use autozimu/LanguageClient-neovim
" Plug 'racer-rust/vim-racer', {
"       \   'for': ['rust']
"       \ }
" if (s:deoplete_enable == 1)
"   Plug 'sebastianmarkow/deoplete-rust', {
"         \   'for': ['rust']
"         \ }
" endif

"------------------------------
" Elixir
Plug 'elixir-lang/vim-elixir', {
      \   'for': ['elixir']
      \ }
Plug 'slashmili/alchemist.vim', {
      \   'for': ['elixir']
      \ }

"------------------------------
" ansible
Plug 'pearofducks/ansible-vim', {
      \   'for': ['yaml', 'ansible']
      \ }

"------------------------------
" Terraform
Plug 'hashivim/vim-terraform', {
      \   'for': ['terraform']
      \ }

"------------------------------
" Markdown
Plug 'previm/previm', {
      \   'for': ['markdown']
      \ }
Plug 'gabrielelana/vim-markdown', {
      \   'for': ['markdown']
      \ }

"------------------------------
" DB
"Plug 'dbext.vim' " helptagのエラーが出る。とりあえず使わないので無効。

"------------------------------
" CSV
Plug 'mechatroner/rainbow_csv', {
      \   'for': ['csv']
      \ }

"------------------------------
" Vimscript
Plug 'mopp/layoutplugin.vim', {
      \   'on': ['LayoutPlugin']
      \ }
Plug 'Shougo/neco-vim', {
      \   'for': ['vim']
      \ }
" Plug 'vim-jp/vital.vim'


"------------------------------------------------------------
" Load local plugins
if filereadable(expand('~/.vimrc.pluginlist.local'))
  source ~/.vimrc.pluginlist.local
endif


"==============================================================
"          Disable                                          {{{
"==============================================================

"Plug 'bronson/vim-trailing-whitespace' -> ntpeters/vim-better-whitespace
"Plug 'tpope/vim-speeddating' " -> didn't use
" Use fzf.vim
""------------------------------
"" Unite/denite
"if (has('nvim') || v:version >= 800) && has('python3')
"  Plug 'Shougo/denite.nvim'
"else
"  Plug 'Shougo/unite.vim'
"  Plug 'ujihisa/unite-locate'
"  Plug 'Shougo/neomru.vim'
"  Plug 'Shougo/neoyank.vim'
"  Plug 'Shougo/unite-build'
"  Plug 'thinca/vim-qfreplace'
"  Plug 'ujihisa/quicklearn'
"  Plug 'Shougo/unite-outline'
"  Plug 'tsukkee/unite-tag'
"  Plug 'tsukkee/unite-help'
"  Plug 'ujihisa/unite-colorscheme'
"  Plug 'thinca/vim-unite-history'
"  Plug 'osyo-manga/unite-quickfix'
"  Plug 'osyo-manga/unite-quickrun_config'
"  Plug 'tacroe/unite-mark'
"  Plug 'amitab/vim-unite-cscope'
"  Plug 'kmnk/vim-unite-giti'
"  Plug 'osyo-manga/unite-highlight'
"  Plug 'yuku-t/vim-ref-ri'
"endif
"
""------------------------------
"" CtrlP
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'sgur/ctrlp-extensions.vim'
"Plug 'tacahiroy/ctrlp-funky'
"Plug 'jasoncodes/ctrlp-modified.vim'

" Conflict with vim-polyglot
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/vimfiler', { " -> vim-dirvish
"       \   'on': [ 'VimFilerTab', 'VimFiler', 'VimFilerExplorer' ]
"       \ }
"depend 'Shougo/unite.vim'
" not used recently
" Plug 'Shougo/neopairs.vim'
" not used recently
"Plug 'Shougo/vimproc.vim', {
"      \   'do': 'make',
"      \ }
"Plug 'Shougo/vimshell', {
"      \   'on': [ 'VimShellBufferDir' ],
"      \ }
""depend 'Shougo/vimproc.vim'
"------------------------------
" Rarely used
" Plug 'FredKSchott/CoVim', {
"       \   'on': [ 'CoVim' ]
"       \ }

"------------------------------
" broken plugins
"Plug 'fidian/hexmode' " -> ;3R display
"" Tag
"Plug 'szw/vim-tags' " -> broken in tmux
"" Fold
"Plug 'Konfekt/FastFold' " -> too slow boot
" unused plugins
"Plug 'miyakogi/conoline.vim' " -> cool highlight current line
" Plug 'plasticboy/vim-markdown', { " -> link paste is wrong
" \   'for': ['markdown']
" \ }
" "depend 'godlygeek/tabular'
" Plug 'godlygeek/tabular'

"------------------------------
" old plugins
" Plug 'osyo-manga/vim-snowdrop', {
"     \   'for': ['c', 'cpp'],
"     \ }
" Plug 'osyo-manga/vim-reunions'
" Plug 'osyo-manga/vim-marching', { " -> difficult include path
" \   'for': ['c', 'cpp']
" \ }
" "depend 'Shougo/vimproc.vim'
" "depend 'osyo-manga/vim-reunions'
"Plug 'troydm/easybuffer.vim' " -> vim-buffergator
"Plug 'jiangmiao/auto-pairs' " -> ignore autopair if next char is not a blank
"Plug 'herry/auto-pairs'
"Plug 'eapache/auto-pairs'
"Plug 'Raimondi/delimitMate' -> lexima
"Plug 'optroot/auto-pairs' " -> it's many features than 'delimitMate'
"Plug 'bkad/CamelCaseMotion' " -> 'vim-scripts/camelcasemotion' '{' wrong motion
"Plug 'junegunn/gv.vim' " -> cohama/agit.vim
"Plug 'fuenor/im_control.vim'  " ibus 制御 -> unused
"Plug 'scrooloose/syntastic' " -> watchdogs
"Plug 'mkitt/tabline' " -> lightline
"Plug 'gcmt/taboo' " -> lightline
"Plug 'bootleq/vim-tabline' " -> lightline
"Plug 'zefei/vim-wintabs' " -> ap/vim-buftabline tabとbufferを分けられて
"                                   素敵だが番号が表示できない
"Plug 'vim-scripts/BufLine' " -> ap/vim-buftabline シンプルでいい
"Plug 'bling/vim-bufferline' " -> ap/vim-buftabline lightlineと組み合わせ
"                                      られる
"Plug 'zefei/vim-wintabs'
"Plug 'terryma/vim-multiple-cursors' " -> strange behavior
"Plug 'xolox/vim-easytags' " -> syntax highlight use tags. can't use.
"Plug 'bbchung/clighter' " -> syntax highlight use libclang.
"                                  can't load libclang.
"Plug 'jeaye/color_coded' " -> syntax highlight use clang. can't build.
"Plug 'MattesGroeger/vim-bookmarks' " -> mark
"Plug 'gregsexton/gitv' " -> cohama/agit.vim
"Plug 'fholgado/minibufexpl.vim' " -> easybuffer
"Plug 'tpope/vim-unimpaired' " -> Raimondi/delimitMate
"Plug 'godlygeek/tabular' " -> junegunn/vim-easy-align
"Plug 'benmills/vimux' " -> move tmux and type command
"Plug 'nathanaelkane/vim-indent-guides' " -> Yggdroot/indentLine
"Plug 'bling/vim-airline' " -> itchyny/lightline.vim
"Plug 'justinmk/vim-sneak' " -> easymotion
"Plug 't9md/vim-smalls' " -> easymotion
"Plug 'taglist.vim' " -> tagbar
"Plug 'wesleyche/SrcExpl' " include many bugs -> autopreview
"Plug 'Trinity' " -> tagbar, nerdtree, autopreview
"Plug 'thinca/vim-openbuf' " -> easybuffer
"Plug 'sjl/gundo.vim' " -> undotree
"Plug 'thinca/vim-localrc' " -> embear/vim-localvimrc
"Plug 'tpope/vim-commentary' " -> The-NERD-Commenter
"Plug 'tomtom/tcomment_vim' " -> The-NERD-Commenter
"Plug 'tyru/caw.vim' " -> The-NERD-Commenter
"Plug 'Rip-Rip/clang_complete' " -> vim-clang
"Plug 'Valloric/YouCompleteMe' " -> vim-clang
"Plug 'L9' " -> dependent on FuzzyFinder
"Plug 'FuzzyFinder' " -> unite
"Plug 'ZenCoding.vim' " -> mattn/emmet-vim
"Plug 'jelera/vim-javascript-syntax'
"Plug 'YankRing.vim' " -> LeafCage/yankround.vim
"Plug 'AutoComplPop' " neocomplcache と競合
"Plug 'ref.vim' " インデックス範囲外のエラーが出る
"Plug 'motemen/hatena-vim'
"Plug 'mattn/unite-advent_calendar'
"Plug 'Townk/vim-autoclose' " 補完時のEscと干渉 -> Raimondi/delimitMate

call plug#end()

" }}}

