
"==============================================================
"          Plugins                                          {{{
"==============================================================

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
" Editing

"------------------------------
" Key Bind (Map)
Plug 'tpope/vim-rsi'
Plug 'kana/vim-smartchr'
Plug 'kana/vim-arpeggio'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

"------------------------------
" Move
Plug 'Lokaltog/vim-easymotion'
Plug 'rhysd/clever-f.vim'
Plug 'unblevable/quick-scope'
Plug 'osyo-manga/vim-milfeulle'
Plug 'justinmk/vim-ipmotion'
Plug 'bkad/CamelCaseMotion'
Plug 'rhysd/accelerated-jk'
Plug 'haya14busa/vim-edgemotion'
Plug 'arp242/jumpy.vim'

"------------------------------
" Select
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
" Plug 'mg979/vim-visual-multi' " -> mapping infection
Plug 'machakann/vim-sandwich'

"------------------------------
" Edit/Insert
Plug 'junegunn/vim-easy-align', {
      \   'on': ['EasyAlign'],
      \ }
Plug 'AndrewRadev/sideways.vim', {
      \   'on': ['SidewaysLeft', 'SidewaysRight'],
      \ }
Plug 'dhruvasagar/vim-table-mode'
Plug 'thinca/vim-partedit'
Plug 'mopp/vim-operator-convert-case'
Plug 'machakann/vim-swap'

"------------------------------
" Text Object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'mattn/vim-textobj-url'
Plug 'wellle/targets.vim'
" slow on startup
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-textobj-function'
" Plug 'kana/vim-textobj-datetime'
" Plug 'lucapette/vim-textobj-underscore'
" Plug 'sgur/vim-textobj-parameter'

"------------------------------
" Operator
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

"---------------
" Join
Plug 'AndrewRadev/splitjoin.vim'
Plug 'osyo-manga/vim-jplus'

"---------------
" Number
Plug 'deris/vim-rengbang'
Plug 'syngan/vim-clurin'

"------------------------------
" Yank
if has('nvim')
  " https://github.com/neovim/neovim/issues/1822
  Plug 'bfredl/nvim-miniyank'
else
  Plug 'svermeulen/vim-yoink'
endif
if !has('nvim')
  Plug 'svermeulen/vim-subversive'
endif
Plug 'chikatoike/concealedyank.vim'

"------------------------------
" Paste
Plug 'junegunn/vim-peekaboo'


"------------------------------------------------------------
" Search

"------------------------------
" Find
if !has('nvim')
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
endif
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'
Plug 't9md/vim-quickhl'

"------------------------------
" Replace
Plug 'tpope/vim-abolish'

"------------------------------
" Grep tool
Plug 'mhinz/vim-grepper'


"------------------------------------------------------------
" File switcher

"------------------------------
" Buffer
Plug 'schickling/vim-bufonly'
Plug 'moll/vim-bbye'

"------------------------------
" Buffer switcher
"Plug 'jlanzarotta/bufexplorer' " -> can't open split window
Plug 'mg979/vim-xtabline'

"------------------------------
" Tab
Plug 'kana/vim-tabpagecd'
"Plug 'taohex/lightline-buffer' " -> 今後に期待

"------------------------------
" Filer
"if has('nvim') && has('python3')
"  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'lambdalisue/fern.vim'
"endif
" -> coc-explorer
Plug 'yegappan/mru' " ファイル編集履歴リスト

"------------------------------
" Window
Plug 't9md/vim-choosewin'
Plug 'blueyed/vim-diminactive'
Plug 'simeji/winresizer'
Plug 'zhaocai/GoldenView.Vim'


"------------------------------------------------------------
" Appearance

"------------------------------
" ColorScheme
Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'} " support coc and lightline
"Plug 'micke/vim-hybrid'
"Plug 'ajmwagar/vim-deus' " support coc
"Plug 'kjssad/quantum.vim' " support coc
"Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'rhysd/vim-color-spring-night'
"Plug 'arcticicestudio/nord-vim'
"Plug 'gruvbox-community/gruvbox'
"Plug 'sainnhe/edge' " support coc and lightline
"Plug 'sainnhe/vim-color-forest-night' " support coc and lightline
"Plug 'cocopon/iceberg.vim'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'tomasr/molokai'
"Plug 'nanotech/jellybeans.vim'

"------------------------------
" Statusline
Plug 'itchyny/lightline.vim'

"------------------------------
" Highlight
" coc-highlight

"------------------------------
" Layout
Plug 'myusuf3/numbers.vim'
Plug 'junegunn/goyo.vim', {
      \   'on': [ 'Goyo' ],
      \ }

"------------------------------
" Font
if !exists('$DISABLE_DEVICONS') || $DISABLE_DEVICONS == 'false'
  Plug 'ryanoasis/vim-devicons' " -> Mojibake
endif

"------------------------------
" StartMenu
Plug 'mhinz/vim-startify'


"------------------------------------------------------------
" Standard Feature Enhancement

"------------------------------
" Undo
Plug 'mbbill/undotree'

"------------------------------
" Diff
Plug 'AndrewRadev/linediff.vim'
Plug 'chrisbra/vim-diff-enhanced'

"------------------------------
" Mark
Plug 'kshenoy/vim-signature'

"------------------------------
" Fold
Plug 'LeafCage/foldCC'

"------------------------------
" Manual
Plug 'thinca/vim-ref'
Plug 'reireias/vim-cheatsheet'
Plug 'liuchengxu/vim-which-key'

"------------------------------
" Tag
" https://github.com/ludovicchabant/vim-gutentags/issues/269
" https://github.com/ludovicchabant/vim-gutentags/issues/178
Plug 'ludovicchabant/vim-gutentags', {
      \   'on': [ 'GutentagsToggleEnabled' ]
      \ }
Plug 'skywind3000/gutentags_plus'

"------------------------------
" Quickfix
Plug 'tyru/qfhist.vim'
Plug 'ronakg/quickr-preview.vim'
Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'yssl/QFEnter'
" conflict? vim-plug & lightline & rust.vim
" https://github.com/junegunn/vim-plug/issues/945
"Plug 'romainl/vim-qf'

"------------------------------
" Session
Plug 'tpope/vim-obsession'

"------------------------------
" Macro
Plug 'zdcthomas/medit'

"------------------------------
" SpellCheck
"Plug 'kamykn/spelunker.vim' " -> buffer switch is too slow
" coc-spell-checker
Plug 'rhysd/vim-grammarous'
if executable('aspell')
  Plug 'shinglyu/vim-codespell'
endif
if !has('nvim')
  Plug 'heavenshell/vim-textlint'
endif

"------------------------------
" Command
Plug 'lambdalisue/suda.vim'
Plug 'vim-scripts/CmdlineComplete'
Plug 'tyru/capture.vim'

"------------------------------
" Visual Mode
Plug 'kana/vim-niceblock'

"------------------------------
" Terminal
if has('nvim')
  Plug 'kassio/neoterm'
endif
Plug 'rhysd/reply.vim'


"------------------------------------------------------------
" New features

"------------------------------
" Translate
" coc-translator

"------------------------------
" Screenshot
Plug 'segeljakt/vim-silicon'

"------------------------------
" Memo
Plug 'glidenote/memolist.vim'

"------------------------------
" Hex
Plug 'Shougo/vinarise.vim'

"------------------------------
" Browser integration
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

"------------------------------
" Mode extension
Plug 'kana/vim-submode'

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
if has('nvim')
  Plug 'yuki-ycino/fzf-preview.vim'
    Plug 'Shougo/neomru.vim'
endif

"------------------------------
" other
" Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }


"------------------------------------------------------------
" Coding

"------------------------------
" Writing assistant
Plug 'scrooloose/nerdcommenter'
Plug 'cometsong/CommentFrame.vim'
Plug 'ntpeters/vim-better-whitespace'

"------------------------------
" Brackets
Plug 'kien/rainbow_parentheses.vim'
Plug 'andymass/vim-matchup'
Plug 'cohama/lexima.vim'

"------------------------------
" Reading assistant
Plug 'Yggdroot/indentLine'
Plug 'wellle/context.vim'

"------------------------------
" Code jump
Plug 'liuchengxu/vista.vim'
Plug 'kana/vim-altr'

"------------------------------
" Task runner
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'igemnace/vim-makery'
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/asyncrun.vim'

"------------------------------
" Lint

"------------------------------
" Format
Plug 'sgur/vim-editorconfig'
Plug 'Chiel92/vim-autoformat'

"------------------------------
" Auto Completion
let s:coc_enable = 0
let s:asynccomplete_enable = 0
if ((has('nvim') || v:version >= 801) && executable('node'))
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
  let g:coc_global_extensions = [
        \ 'coc-marketplace',
        \ 'coc-tag',
        \ 'coc-dictionary',
        \ 'coc-word',
        \ 'coc-emoji',
        \ 'coc-omni',
        \ 'coc-syntax',
        \ 'coc-emmet',
        \ 'coc-lists',
        \ 'coc-snippets',
        \ 'coc-yank',
        \ 'coc-json',
        \ 'coc-yaml',
        \ 'coc-sh',
        \ 'coc-python',
        \ 'coc-rust-analyzer',
        \ 'coc-clangd',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-diagnostic',
        \ 'coc-tabnine',
        \ 'coc-highlight',
        \ 'coc-git',
        \ 'coc-explorer',
        \ 'coc-spell-checker',
        \ 'coc-actions',
        \ 'coc-project',
        \ 'coc-todolist',
        \ 'coc-template',
        \ 'coc-translator',
        \ ]

  if executable('aspell')
    call add(g:coc_global_extensions, 'coc-nextword')
  endif

        " \ 'coc-lines', " -> too many candidates for completion
        " \ 'coc-pairs', " -> change lexima because it's too simple
        " \ 'coc-smartf', " -> clever-f, easymotion I want to search with only one line, but it can't

  let s:coc_enable = 1
else
  Plug 'prabirshrestha/asyncomplete.vim'
  let s:asynccomplete_enable = 1
endif

"------------------------------
" Language Server Protocol(LSP)
if (s:asynccomplete_enable == 1)
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'mattn/vim-lsp-settings'
endif

"------------------------------
" Tabnine
" Plug 'zxqfl/tabnine-vim'

"------------------------------
" Snippet
Plug 'honza/vim-snippets'
if (s:coc_enable == 0)
  Plug 'SirVer/ultisnips'
endif
" coc-template

"------------------------------
" Project
Plug 'airblade/vim-rooter'
Plug 'embear/vim-localvimrc'

"------------------------------
" Git
if str2float(matchstr(system('git --version'), '\%(\d\.\)\+\d')) >= 1.9 &&
      \ (has('nvim') || ((v:version == 800 && has('patch27')) || v:version >= 801))
  Plug 'lambdalisue/gina.vim'
endif
Plug 'mattn/vim-gist'
Plug 'cohama/agit.vim'
Plug 'idanarye/vim-merginal'
Plug 'rhysd/committia.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'hotwatermorning/auto-git-diff'

"------------------------------
" Debugger
if has('nvim')
  Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
endif
" setup is very difficult, but debugger protocol is good feature.
"Plug 'puremourning/vimspector', { 'do': ':!./install_gadget.py --all' }


"------------------------------------------------------------
" Programing Languages

"------------------------------
" Clang
Plug 'rhysd/vim-clang-format', {
      \   'for': ['c', 'cpp', 'objc']
      \ }

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

"------------------------------
" HTML
Plug 'hokaccha/vim-html5validator', {
      \   'for': ['html']
      \ }

"------------------------------
" CSS

"------------------------------
" Javascript
Plug 'ternjs/tern_for_vim', {
      \   'for': ['javascript']
      \ }

"------------------------------
" Vue

"------------------------------
" Riot

"------------------------------
" Python
Plug 'python-mode/python-mode', {
      \   'branch': 'develop',
      \   'for': ['python']
      \ }
Plug 'mgedmin/python-imports.vim', {
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

"------------------------------
" Rust
Plug 'rust-lang/rust.vim', {
      \   'for': ['rust']
      \ }

"------------------------------
" Elixir
Plug 'slashmili/alchemist.vim', {
      \   'for': ['elixir']
      \ }

"------------------------------
" ansible

"------------------------------
" Terraform

"------------------------------
" Markdown
if has('nvim') || v:version >= 801
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync(v:true) }}
endif
Plug 'SidOfc/mkdx', {
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
" Json
Plug 'neoclide/jsonc.vim', {
      \   'for': ['json', 'jsonc']
      \ }

"------------------------------
" PlantUML
Plug 'scrooloose/vim-slumlord', {
      \   'for': ['plantuml']
      \ }

"------------------------------
" Vimscript
Plug 'mopp/layoutplugin.vim', {
      \   'on': ['LayoutPlugin']
      \ }
" Plug 'vim-jp/vital.vim'
Plug 'Shougo/neco-vim', {
      \   'for': ['vim']
      \ }
if get(s:, 'coc_enable', 0) && (s:coc_enable == 1)
  Plug 'neoclide/coc-neco', {
        \   'for': ['vim']
        \ }
endif


"------------------------------------------------------------
" Defer Load Plugins

"------------------------------
" Syntax
Plug 'sheerun/vim-polyglot'


"------------------------------------------------------------
" Load local plugins
if filereadable(expand('~/.vimrc.pluginlist.local'))
  source ~/.vimrc.pluginlist.local
endif


"==============================================================
"          Disable                                          {{{
"==============================================================

"markonm/traces.vim " -> neovim set inccommand=split
" coc-translator
"Plug 'echuraev/translate-shell.vim'
"Plug 'haya14busa/vim-open-googletranslate'
"Plug 'mattn/vim-sonictemplate' " -> coc-template
" -> mkdx
"Plug 'plasticboy/vim-markdown', {
"      \   'for': ['markdown']
"      \ }
" rust doesn't suuport
"inkarkat/vim-CountJump
"Plug 'RobertCWebb/vim-jumpmethod'
"Plug 'jeetsukumaran/vim-buffergator' " -> fzf-preview
" -> fzf-preview.vim
"Plug 'pbogut/fzf-mru.vim'
"Plug 'tweekmonster/fzf-filemru'
"raghur/fruzzy " -> fzf
"Yggdroot/LeaderF " -> fzf
"lotabout/skim " " -> fzf
"thinca/vim-poslist " -> osyo-manga/vim-milfeulle
"Plug 'mhinz/vim-signify' " -> coc-git
"Plug 'farmergreg/vim-lastplace' " do not use
" tyru/caw.vim, /tomtom/tcomment_vim " -> nerdcommenter
"Plug 'Shougo/neosnippet' " -> ultisnips
"Plug 'Shougo/neosnippet-snippets'
"Plug 'tpope/vim-endwise', { " -> cohama/lexima.vim
"      \   'for': ['ruby']
"      \ }
"Plug 'godlygeek/tabular', { " -> dhruvasagar/vim-table-mode
"      \   'on': [ 'Tabularize' ],
"      \ }
"Plug 'tpope/vim-unimpaired' " -> slow on startup
"Plug 'osyo-manga/vim-automatic' " -> zhaocai/GoldenView.Vim because slow startup
"Plug 'osyo-manga/vim-trip' " -> syngan/vim-clurin
"Plug 'vim-scripts/camelcasemotion' " -> bkad/CamelCaseMotion because too old

" not using
"Plug 'emonkak/vim-operator-comment'
"Plug 'emonkak/vim-operator-sort'
"Plug 'ToruIwashita/git-switcher.vim' " -> vim-obsession
"Plug 'rhysd/vim-operator-surround' " -> vim-sandwich
"Plug 'wincent/ferret' " -> vim-grepper
"Plug 'osyo-manga/vim-over' " -> default feature
"Plug 'osyo-manga/vim-hopping' " -> CocList
" bootleq/vim-cycle, zef/vim-cycle, AndrewRadev/switch.vim " -> syngan/vim-clurin
" coc-spell-checker
"Plug 'inkarkat/vim-ingo-library'
"Plug 'inkarkat/vim-spellcheck'
" inkarkat/vim-SearchHighlighting, highlight_word_under_cursor.vim,
" HiCursorWords, bronson/vim-visual-star-search, thinca/vim-visualstar,
" luochen1990/select-and-search, qstrahl/vim-matchmaker, itchyny/vim-cursorword,
" timakro/vim-searchant " -> vim-asterisk
" Plug 'nelstrom/vim-visual-star-search' " -> conflict vim-asterisk
" dpelle/vim-LanguageTool " -> rhysd/vim-grammarous
" thirtythreeforty/lessspace.vim " vim-better-whitespace
" tommcdo/vim-exchange " vim-swap
" tommcdo/vim-lion " vim-easy-align
" tpope/vim-sleuth " vim-polyglot
" romainl/vim-cool " I don't use disables search highlighting
" PeterRincker/vim-argumentative " vim-swap
" FooSoft/vim-argwrap " I use each lang formatter
" ryanoasis/vim-devicons " I don't use icons
"Plug 'tpope/vim-fugitive' " -> coc-git
"Plug 'svermeulen/vim-easyclip' " -> vim-cutlass, vim-yoink, vim-subversive
"Plug 'LeafCage/yankround.vim' " -> svermeulen/vim-yoink
"Plug 'chrisbra/Colorizer' " -> coc-highlight
"Plug 'RRethy/vim-illuminate' " -> coc-highlight
"Plug 'vim-scripts/grep.vim' " -> mhinz/vim-grepper
" Plug 'w0ng/vim-hybrid' " kristijanhusak/vim-hybrid-material
" not support deoplete
" let s:deoplete_enable = 0
"elseif has('nvim') && has('python3')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  if exists('##CompleteChanged')
"    Plug 'ncm2/float-preview.nvim'
"  endif
"  Plug 'Shougo/echodoc.vim'
"  Plug 'Shougo/neco-syntax'
"  let s:deoplete_enable = 1
"elseif (s:deoplete_enable == 1)
"  Plug 'autozimu/LanguageClient-neovim', {
"        \ 'branch': 'next',
"        \ 'do': 'bash install.sh',
"        \ }
"if (s:deoplete_enable == 1)
"  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"else

" dispath
" Plug 'thinca/vim-quickrun'
" Plug 'dannyob/quickfixstatus'
" Plug 'KazuakiM/vim-qfstatusline'
" Plug 'osyo-manga/shabadou.vim'

" Use LSP
"Plug 'Shougo/neoinclude.vim', {
"      \   'for': ['c', 'cpp', 'objc']
"      \ }
"if (s:coc_enable == 1)
"  Plug 'jsfaint/coc-neoinclude', {
"      \   'for': ['c', 'cpp', 'objc']
"      \ }
"endif
" Plug 'Shougo/neomru.vim'
" Plug 'justinmk/vim-dirvish' " -> defx
" Plug 'kristijanhusak/vim-dirvish-git'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'scrooloose/nerdtree', { " -> defx
"       \   'on': ['NERDTree', 'NERDTreeToggle'],
"       \ }
" Plug 'majutsushi/tagbar' " -> vista.vim
" Plug 'airblade/vim-gitgutter' " -> coc-git
" if ((v:version == 800 && has('patch27')) || v:version >= 801) " -> coc.nvim
"       \ || has('nvim')
"   Plug 'w0rp/ale'
" endif
" Plug 'xolox/vim-session' " -> tpope/vim-obsession
" "depend 'xolox/vim-misc'
" Plug 'xolox/vim-misc'
" Plug 'tyru/operator-camelize.vim' " -> mopp/vim-operator-convert-case
" Plug 'mattn/emmet-vim', { " -> coc-emmet
"       \   'for': ['html']
"       \ }
" Plug 'haya14busa/vim-operator-flashy' " -> coc-yank
"" depend 'kana/vim-operator-user'
" use lsp (vim-language-server)
" Plug 'vim-scripts/sudo.vim' " -> suda.vim
" Plug 'vim-scripts/autopreview' " -> use lsp
" Plug 'ap/vim-buftabline' " -> vim-xtabline
"if has('nvim') " -> nvim-gdb
"  Plug 'critiqjo/lldb.nvim', {
"        \   'for': ['c', 'cpp'],
"        \   'do': ':UpdateRemotePlugins'
"        \ }
"endif
"Plug 'osyo-manga/vim-brightest', { " -> RRethy/vim-illuminate
"      \   'on': [ 'BrightestEnable', 'BrightestToggle' ]
"      \ }
" because dislike the autoclear
" if ((v:version == 800 && has('patch1238')) || v:version >= 801)
"   Plug 'haya14busa/is.vim'
" endif
" Plug 'neomake/neomake' " -> ale
" too old
" else
"   Plug 'Shougo/vimproc.vim', {
"         \   'do': 'make',
"         \ }
"   Plug 'osyo-manga/vim-watchdogs'
"   Plug 'cohama/vim-hier'
"   Plug 'KazuakiM/vim-qfsigns'
"   "depend 'Shougo/vimproc.vim'
"   "depend 'thinca/vim-quickrun'
"   "depend 'osyo-manga/shabadou.vim'
"   "depend 'KazuakiM/vim-qfsigns'
"   "depend 'dannyob/quickfixstatus'
"   "depend 'KazuakiM/vim-qfstatusline'
"   "depend 'cohama/vim-hier'
"" neocompleteの対応を確認する
" function! s:meet_neocomplete_requirements() abort
"   return has('lua') && (v:version > 703 || (v:version == 703
"         \ && has('patch885')))
" endfunction
" elseif (v:version == 800) && (has('python3') || has('python'))
"   Plug 'maralla/completor.vim'
" else
"   if s:meet_neocomplete_requirements()
"     Plug 'Shougo/neocomplete.vim'
"   else
"     Plug 'Shougo/neocomplcache.vim'
"   endif
"Plug 'Valloric/ListToggle' " -> vim-qf
" united python-mode
"Plug 'andviro/flake8-vim', {
"      \   'for': ['python']
"      \ }
"Plug 'hynek/vim-python-pep8-indent', {
"      \   'for': ['python']
"     \ }
"Plug 'tpope/vim-surround' " -> vim-sandwich
"Plug 'greymd/oscyank.vim' " -> worked without this
" Plug 'Houl/repmo-vim' " -> can't repeat ]]
" Error Undefined variable: mappings -> switch default to osyo-manga/vim-milfeulle
"Plug 'inkarkat/vim-ingo-library'
"Plug 'inkarkat/vim-EnhancedJumps'
" Debugger
"Plug 'gilligan/vim-lldb' " -> only lldb
"Plug 'dbgx/lldb.nvim' " -> require Neovim python2-client
"Plug 'huawenyu/neogdb.vim' " -> Not supoprt lldb
"Plug 'vim-vdebug/vdebug' " -> Not support C++,Rust
"Plug 'skyshore2001/vgdb-vim' " -> Not recently updated. sakhnik/nvim-gdb
"Plug 'cpiger/NeoDebug' " -> Not recently updated.
"Plug 'vim-scripts/Conque-GDB' " -> too old
"Plug 'idanarye/vim-vebugger' " -> require vimproc
" included polyglot
" Plug 'octol/vim-cpp-enhanced-highlight', {
"       \   'for': ['c', 'cpp', 'objc']
"       \ }
" Plug 'othree/html5.vim', {
"       \   'for': ['html']
"       \ }
" Plug 'hail2u/vim-css3-syntax', {
"       \   'for': ['css']
"       \ }
" Plug 'groenewege/vim-less', {
"       \   'for': ['css']
"       \ }
" Plug 'pangloss/vim-javascript', {
"       \   'for': ['javascript']
"       \ }
" Plug 'posva/vim-vue', {
"       \   'for': ['vue']
"       \ }
" Plug 'ryym/vim-riot', {
"       \   'for': ['riot']
"       \ }
" Plug 'elixir-lang/vim-elixir', {
"       \   'for': ['elixir']
"       \ }
" Plug 'pearofducks/ansible-vim', {
"       \   'for': ['yaml', 'ansible']
"       \ }
" Plug 'hashivim/vim-terraform', {
"       \   'for': ['terraform']
"       \ }
"
" Change to LSP from deoplete
"if (s:deoplete_enable == 1)
"  " Plug 'zchee/deoplete-clang', {
"  "       \   'for': ['c', 'cpp'],
"  "       \ }
"else
"  Plug 'justmao945/vim-clang', {
"        \   'for': ['c', 'cpp'],
"        \ }
"endif
"if (s:deoplete_enable == 1)
"  Plug 'carlitux/deoplete-ternjs'
"  ", { 'do': 'npm install -g tern' }
"  Plug 'mhartington/deoplete-typescript', {
"        \   'for': ['typescript']
"        \ }
"endif
"if (s:deoplete_enable == 1)
"  Plug 'zchee/deoplete-jedi', {
"        \   'for': ['python']
"        \ }
"else
"  Plug 'davidhalter/jedi-vim', {
"        \   'for': ['python']
"        \ }
"endif
"if (s:deoplete_enable == 1)
"  Plug 'zchee/deoplete-go', {
"        \   'for': ['go'],
"        \   'do': 'make'
"        \ }
"endif
" use autozimu/LanguageClient-neovim
" Plug 'racer-rust/vim-racer', {
"       \   'for': ['rust']
"       \ }
" if (s:deoplete_enable == 1)
"   Plug 'sebastianmarkow/deoplete-rust', {
"         \   'for': ['rust']
"         \ }
" endif
"Plug 'deris/vim-shot-f' " -> conflict clever-f
" -> ludovicchabant/vim-gutentags
" Plug 'vim-scripts/gtags.vim', {
"       \   'for': ['c', 'cpp', 'java'],
"       \ }
" vim-matchup
"if (v:version == 704 && has('patch786')) || v:version >= 705
"  let g:loaded_matchparen = 1 | Plug 'itchyny/vim-parenmatch'
"endif
"Plug 'milkypostman/vim-togglelist' -> Valloric/ListToggle
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
" Plug 'gabrielelana/vim-markdown', { " -> plasticboy/vim-markdown
"       \   'for': ['markdown']
"       \ }
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
"Plug 'Raimondi/delimitMate' " -> lexima
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

