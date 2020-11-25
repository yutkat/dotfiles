
"===============================================================
"          Plugin Settings                                   {{{
"===============================================================

" plugin installed check
let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.is_installed(name) abort
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction


"===============================
" ColorScheme                {{{
"===============================

"-------------------------------
" gruvbox-material
if s:plug.is_installed('gruvbox-material')
  " let s:lightline_colorscheme = 'gruvbox_material'
  let s:lightline_colorscheme = 'wombat'
  set background=dark
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_transparent_background = 1
  let g:gruvbox_material_enable_bold = 1
  let g:gruvbox_material_disable_italic_comment = 1
  colorscheme gruvbox-material
endif

"-------------------------------
" default
if !exists('g:colors_name')
  colorscheme desert
  highlight Pmenu ctermfg=Black ctermbg=Gray guifg=Black guibg=Gray
  highlight PmenuSel ctermfg=Black ctermbg=Cyan guifg=Black guibg=Cyan
  highlight PmenuSbar ctermfg=White ctermbg=DarkGray guifg=White guibg=DarkGray
  highlight PmenuThumb ctermfg=DarkGray ctermbg=White guifg=DarkGray guibg=White
endif

" }}}


"==============================
" etc                       {{{
"==============================

"-------------------------------
" matchit.vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"-------------------------------
" vim-plug
if s:plug.is_installed('vim-plug')
  " command! PlugReload call map(keys(filter(copy(g:), "v:key =~ '^loaded_' && v:key !~ 'loaded_.*_provider$'")), {_, v -> execute("unlet g:" . v)}) |
  "      \ source $MYVIMRC
endif

"-------------------------------
" yankround
if s:plug.is_installed('yankround.vim')
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100
  let g:yankround_dir = '~/.cache/yankround'
  nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
  "nnoremap <silent><SID>(ctrlp) :<C-u>CtrlP<CR>
  "nmap <expr><C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "<SID>(ctrlp)"
endif

"-------------------------------
" cscope
if has('cscope')
  set nocst
  set csto=0
  set csre
  set nocsverb
  " add any database in current directory
  if filereadable('cscope.out')
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB !=? ''
    cs add $CSCOPE_DB
  endif
  set csverb
  " To open quickfix annoying
  " set cscopequickfix=s-,c-,d-,i-,t-,e-
  nnoremap <cscope> <Nop>
  nmap <SubLeader>c <cscope>
  nmap <cscope>s :<C-u>cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>g :<C-u>cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>c :<C-u>cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>t :<C-u>cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>e :<C-u>cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>f :<C-u>cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <cscope>i :<C-u>cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <cscope>d :<C-u>cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"-------------------------------
" vim-quickhl
if s:plug.is_installed('vim-quickhl')
  nmap <Leader>m <Plug>(quickhl-manual-this)
  xmap <Leader>m <Plug>(quickhl-manual-this)
  nmap <Leader>M <Plug>(quickhl-manual-reset)
  xmap <Leader>M <Plug>(quickhl-manual-reset)
  nnoremap <silent> <F5> :<C-u>nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>:QuickhlManualReset<CR><C-l>

  if ! IsSupportedTrueColor()
    let g:quickhl_manual_colors = [
          \   'cterm=bold ctermfg=16 ctermbg=214 gui=bold guifg=#000000 guibg=#ffa724',
          \   'cterm=bold ctermfg=16 ctermbg=154 gui=bold guifg=#000000 guibg=#aeee00',
          \   'cterm=bold ctermfg=16 ctermbg=121 gui=bold guifg=#000000 guibg=#8cffba',
          \   'cterm=bold ctermfg=16 ctermbg=137 gui=bold guifg=#000000 guibg=#b88853',
          \   'cterm=bold ctermfg=7  ctermbg=21  gui=bold guifg=#ffffff guibg=#d4a00d',
          \   'cterm=bold ctermfg=16 ctermbg=211 gui=bold guifg=#000000 guibg=#ff9eb8',
          \   'cterm=bold ctermfg=7  ctermbg=22  gui=bold guifg=#ffffff guibg=#06287e',
          \   'cterm=bold ctermfg=16 ctermbg=56  gui=bold guifg=#000000 guibg=#a0b0c0',
          \   'cterm=bold ctermfg=16 ctermbg=153 gui=bold guifg=#ffffff guibg=#0a7383'
          \ ]
  endif
  "nmap <SubLeader>J <Plug>(quickhl-cword-toggle)
  "nmap <SubLeader>] <Plug>(quickhl-tag-toggle)
  "map <SubLeader>H <Plug>(operator-quickhl-manual-this-motion)
endif

"-------------------------------
" vim-expand-region
if s:plug.is_installed('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
endif

"-------------------------------
" vim-easy-align
if s:plug.is_installed('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  xmap <Leader>a <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap <Leader>a <Plug>(EasyAlign)
endif

"-------------------------------
" nerdcommenter
if s:plug.is_installed('nerdcommenter')
  let g:NERDSpaceDelims = 1
  "let g:NERDCompactSexyComs = 1
  let g:NERDDefaultAlign = 'left'
  "let g:NERDAltDelims_java = 1
  "let g:NERDCustomDelimiters = {
  "      \ 'c': { 'left': '/**','right': '*/' },
  "      \ 'cpp': { 'left': '/**','right': '*/' } }
  let g:NERDCommentEmptyLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  nmap <C-_> <Leader>c<Leader>
  vmap <C-_> <Leader>c<Leader>
endif

"-------------------------------
" caw.vim
if s:plug.is_installed('caw.vim')
  map <C-_> <Plug>(caw:hatpos:toggle)
  map gcc <Plug>(caw:hatpos:toggle)
  " vmap <C-_> <Plug>(caw:wrap:toggle)
endif

"-------------------------------
" vim-easymotion
if s:plug.is_installed('vim-easymotion')
    nnoremap <easymotion>   <Nop>
    nmap    S <easymotion>
  " Disable default mappings
  " If you are true vimmer, you should explicitly map keys by yourself.
  " Do not rely on default bidings.
  let g:EasyMotion_do_mapping = 0

  " Or map prefix key at least(Default: <Leader><Leader>)
  " map <Leader> <Plug>(easymotion-prefix)

  " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
  " `s{char}{char}{target}`
  nmap <easymotion>j <Plug>(easymotion-s2)
  xmap <easymotion>j <Plug>(easymotion-s2)
  " nmap ss <Plug>(easymotion-s2)
  " xmap ss <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  " Of course, you can map to any key you want such as `<Space>`
  " map <Space>(easymotion-s2)

  " Turn on case sensitive feature
  "let g:EasyMotion_smartcase = 1

  " `JK` Motions: Extend line motions
  " use relativenumber
  "map <Leader>j <Plug>(easymotion-j)
  "map <Leader>k <Plug>(easymotion-k)
  " keep cursor column with `JK` motions
  let g:EasyMotion_startofline = 0

  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
  " Show target key with upper case to improve readability
  "let g:EasyMotion_use_upper = 1
  " Jump to first match with enter & space
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  " Extend search motions with vital-over command line interface
  " Incremental highlight of all the matches
  " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
  " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
  " :h easymotion-command-line
  nmap <easymotion>/ <Plug>(easymotion-sn)
  xmap <easymotion>/ <Plug>(easymotion-sn)
  omap <easymotion>/ <Plug>(easymotion-tn)

  " 1 ストローク選択を優先する
  let g:EasyMotion_grouping=1

  " カラー設定変更
  " hi EasyMotionTarget ctermbg=NONE ctermfg=red guifg=#E4E500
  " hi EasyMotionShade  ctermbg=NONE ctermfg=blue guifg=#444444
  hi link EasyMotionTarget ErrorMsg
  hi link EasyMotionShade  LineNr

  " <Leader>f{char} to move to {char}
  "map  <Leader>f <Plug>(easymotion-bd-f)
  "nmap <Leader>f <Plug>(easymotion-overwin-f)
  " s{char}{char} to move to {char}{char}
  "nmap s <Plug>(easymotion-overwin-f2)
  " Move to line
  map <easymotion>k <Plug>(easymotion-bd-jk)
  nmap <easymotion>k <Plug>(easymotion-overwin-line)
  " Move to word
  map  <easymotion>S <Plug>(easymotion-bd-w)
  nmap <easymotion>S <Plug>(easymotion-overwin-w)
  map  <easymotion>w <Plug>(easymotion-bd-w)
  nmap <easymotion>w <Plug>(easymotion-overwin-w)

  " etc
  map <easymotion>. <Plug>(easymotion-repeat)
endif

"-------------------------------
" vim-signature
if s:plug.is_installed('vim-signature')
  let g:SignatureMap = {
        \ 'Leader'             :  'm',
        \ 'PlaceNextMark'      :  'm,',
        \ 'ToggleMarkAtLine'   :  'm.',
        \ 'PurgeMarksAtLine'   :  'm-',
        \ 'DeleteMark'         :  'dm',
        \ 'PurgeMarks'         :  'm<Space>',
        \ 'PurgeMarkers'       :  'm<BS>',
        \ 'GotoNextLineAlpha'  :  '',
        \ 'GotoPrevLineAlpha'  :  '',
        \ 'GotoNextSpotAlpha'  :  '`]',
        \ 'GotoPrevSpotAlpha'  :  '`[',
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  ']`',
        \ 'GotoPrevSpotByPos'  :  '[`',
        \ 'GotoNextMarker'     :  ']-',
        \ 'GotoPrevMarker'     :  '[-',
        \ 'GotoNextMarkerAny'  :  ']=',
        \ 'GotoPrevMarkerAny'  :  '[=',
        \ 'ListBufferMarks'    :  'm/',
        \ 'ListBufferMarkers'  :  'm?'
        \ }
endif

"-------------------------------
" vim-gitgutter
if s:plug.is_installed('vim-gitgutter')
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '~'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_realtime = 500
  let g:gitgutter_eager = 500
  let g:gitgutter_diff_args = '-w'
endif

"-------------------------------
" vim-trailing-whitespace
if s:plug.is_installed('vim-trailing-whitespace')
  let g:extra_whitespace_ignored_filetypes =
        \ ['unite', 'markdown', 'vimfiler', 'qf',
        \ 'tagbar', 'nerdtree', 'vimshell', 'minimap']
  augroup vimrc_trailing_whiteSpace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
  augroup END
endif

"-------------------------------
" incsearch.vim
if s:plug.is_installed('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  augroup vimrc_incsearch
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
  augroup END
  function! s:incsearch_keymap() abort
    "IncSearchNoreMap <Right> <Over>(incsearch-next)
    "IncSearchNoreMap <Left>  <Over>(incsearch-prev)
    "IncSearchNoreMap <Down>  <Over>(incsearch-scroll-f)
    "IncSearchNoreMap <Up>    <Over>(incsearch-scroll-b)
    IncSearchNoreMap <Tab>   <Over>(buffer-complete)
    IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
  endfunction
endif

"-------------------------------
" incsearch-fuzzy.vim
if s:plug.is_installed('incsearch-fuzzy.vim')
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
endif

"-------------------------------
" vim-rooter
if s:plug.is_installed('vim-rooter')
  " Change only current window's directory
  let g:rooter_cd_cmd='lcd'
  " To stop vim-rooter changing directory automatically
  let g:rooter_manual_only = 1
  " files/directories for the root directory
  let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
  " Automatically change the directory
  "autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
endif

"-------------------------------
" vim-choosewin
if s:plug.is_installed('vim-choosewin')
  nmap  <Leader>-  <Plug>(choosewin)
  " オーバーレイ機能を有効にしたい場合
  let g:choosewin_overlay_enable          = 1
  " オーバーレイ・フォントをマルチバイト文字を含むバッファでも綺麗に表示する。
  let g:choosewin_overlay_clear_multibyte = 1
endif

"-------------------------------
" vim-localvimrc
if s:plug.is_installed('vim-localvimrc')
  let g:localvimrc_persistent=1
  let g:localvimrc_sandbox=0
endif

"-------------------------------
" vim-altr
if s:plug.is_installed('vim-altr')
  map <F6> <Plug>(altr-forward)
  map <S-F6> <Plug>(altr-back)
  map g<Tab> <Plug>(altr-forward)
  map g<S-Tab> <Plug>(altr-back)
  " map <F3> <Plug>(altr-back)
endif

"-------------------------------
" vim-anzu
if s:plug.is_installed('vim-anzu')
  " mapping
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap g* <Plug>(anzu-star-with-echo)n
  nmap g# <Plug>(anzu-sharp-with-echo)N
  " clear status
  "nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
  " statusline
  if exists('anzu#search_status')
    set statusline=%{anzu#search_status()}
  endif
  " if start anzu-mode key mapping
  " anzu-mode is anzu(12/51) in screen
  " nmap n <Plug>(anzu-mode-n)
  " nmap N <Plug>(anzu-mode-N)
  let g:anzu_bottomtop_word = 'search hit BOTTOM, continuing at TOP'
  let g:anzu_topbottom_word = 'search hit TOP, continuing at BOTTOM'
  let g:anzu_status_format = '%p(%i/%l) %#WarningMsg#%w'
endif

"-------------------------------
" vim-asterisk
if s:plug.is_installed('vim-asterisk')
  map g*  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
  map g#  <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
  map * <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  " map # <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)
  let g:asterisk#keeppos = 1
endif

"-------------------------------
" autopreview
if s:plug.is_installed('autopreview')
  let g:AutoPreview_enabled =0
  set updatetime=100
  set previewheight =8
  nnoremap <SubLeader>t :<C-u>AutoPreviewToggle<CR>
endif

"-------------------------------
" numbers
if s:plug.is_installed('numbers.vim')
  let g:enable_numbers = 0
endif

"-------------------------------
" indentLine
if s:plug.is_installed('indentLine')
  let g:indentLine_enabled = 0
endif

"-------------------------------
" CmdlineComplete
if s:plug.is_installed('CmdlineComplete')
  cmap <C-k> <Plug>CmdlineCompleteBackward
  cmap <C-j> <Plug>CmdlineCompleteForward
endif

"-------------------------------
" vim-milfeulle
if s:plug.is_installed('vim-milfeulle')
  nmap <S-F2> <Plug>(milfeulle-prev)
  nmap <S-F3> <Plug>(milfeulle-next)
  nmap H <Plug>(milfeulle-prev)
  nmap L <Plug>(milfeulle-next)
  let g:milfeulle_default_kind = 'buffer'
  let g:milfeulle_default_jumper_name = 'win_tab_bufnr_pos'
endif

"-------------------------------
" vim-ipmotion
if s:plug.is_installed('vim-ipmotion')
  let g:ip_boundary = '"\?\s*$\n"\?\s*$'
endif

"-------------------------------
" vim-brightest
if s:plug.is_installed('vim-brightest')
  let g:brightest_enable = 0
  let g:brightest#highlight = {
        \   'group' : 'BrightestUnderline'
        \}
endif

"-------------------------------
" vim-hopping
if s:plug.is_installed('vim-hopping')
  " Example key mapping
  nmap <Space>/ <Plug>(hopping-start)
  " Keymapping
  let g:hopping#keymapping = {
        \   "\<C-n>" : '<Over>(hopping-next)',
        \   "\<C-p>" : '<Over>(hopping-prev)',
        \   "\<C-u>" : '<Over>(scroll-u)',
        \   "\<C-d>" : '<Over>(scroll-d)',
        \}
endif

"-------------------------------
" splitjoin.vim
if s:plug.is_installed('splitjoin.vim')
  nmap <SubLeader>J :SplitjoinJoin<cr>
  nmap <SubLeader>S :SplitjoinSplit<cr>
endif

"-------------------------------
" vim-jplus
if s:plug.is_installed('vim-jplus')
  " J の挙動を jplus.vim で行う
  nmap gJ <Plug>(jplus)
  vmap gJ <Plug>(jplus)
  " getchar() を使用して挿入文字を入力します
  " nmap <Leader>J <Plug>(jplus-getchar)
  " vmap <Leader>J <Plug>(jplus-getchar)
  " input() を使用したい場合はこちらを使用して下さい
  nmap <Leader>J <Plug>(jplus-input)
  vmap <Leader>J <Plug>(jplus-input)
  " <Plug>(jplus-getchar) 時に左右に空白文字を入れたい場合
  " %d は入力した結合文字に置き換えられる
  let g:jplus#config = {
        \   '_' : {
        \       'delimiter_format' : '%d'
        \   }
        \}
endif

"-------------------------------
" vim-trip
if s:plug.is_installed('vim-trip')
  nmap + <Plug>(trip-increment)
  nmap - <Plug>(trip-decrement)
endif

"-------------------------------
" vim-buftabline
if s:plug.is_installed('vim-buftabline')
  let g:buftabline_show = 1
  let g:buftabline_numbers = 2
  let g:buftabline_indicators = 1
  nmap <Leader>1 <Plug>BufTabLine.Go(1)
  nmap <Leader>2 <Plug>BufTabLine.Go(2)
  nmap <Leader>3 <Plug>BufTabLine.Go(3)
  nmap <Leader>4 <Plug>BufTabLine.Go(4)
  nmap <Leader>5 <Plug>BufTabLine.Go(5)
  nmap <Leader>6 <Plug>BufTabLine.Go(6)
  nmap <Leader>7 <Plug>BufTabLine.Go(7)
  nmap <Leader>8 <Plug>BufTabLine.Go(8)
  nmap <Leader>9 <Plug>BufTabLine.Go(9)
  nmap <Leader>0 <Plug>BufTabLine.Go(10)
endif

"-------------------------------
" vim-togglelist
if s:plug.is_installed('vim-togglelist')
  nmap <script> <silent> <LocalLeader>l :<C-u>call ToggleLocationList()<CR>
  nmap <script> <silent> <LocalLeader>q :<C-u>call ToggleQuickfixList()<CR>
  let g:toggle_list_copen_command='botright copen'
endif

"-------------------------------
" Valloric/ListToggle
if s:plug.is_installed('ListToggle')
  let g:lt_location_list_toggle_map = '<LocalLeader>l'
  let g:lt_quickfix_list_toggle_map = '<LocalLeader>q'
endif

"-------------------------------
" vim-hier
if s:plug.is_installed('vim-hier')
endif

"-------------------------------
" camelcasemotion
if s:plug.is_installed('camelcasemotion')
  map <silent> <SubLeader>w <Plug>CamelCaseMotion_w
  map <silent> <SubLeader>b <Plug>CamelCaseMotion_b
  map <silent> <SubLeader>e <Plug>CamelCaseMotion_e
  map <silent> <SubLeader>ge <Plug>CamelCaseMotion_ge
endif

"-------------------------------
" CamelCaseMotion
if s:plug.is_installed('CamelCaseMotion')
  map <silent> <SubLeader>w <Plug>CamelCaseMotion_w
  map <silent> <SubLeader>b <Plug>CamelCaseMotion_b
  map <silent> <SubLeader>e <Plug>CamelCaseMotion_e
  map <silent> <SubLeader>ge <Plug>CamelCaseMotion_ge
endif

"-------------------------------
" auto-pairs
if s:plug.is_installed('auto-pairs')
  let g:AutoPairsShortcutToggle = ''
  " let g:AutoPairsOnlyAtEOL = 1
  let g:AutoPairsOnlyBeforeClose = 1
  command! AutoPairsToggle call AutoPairsToggle()
endif

"-------------------------------
" vim-diminactive
if s:plug.is_installed('vim-diminactive')
  let g:diminactive = 0
  let g:diminactive_enable_focus = 1
endif

"-------------------------------
" vim-session
if s:plug.is_installed('vim-session')
  function! s:session_config(dir) abort
    " session保存ディレクトリをそのディレクトリの設定
    let g:session_directory = a:dir
    " vimを辞める時に自動保存
    " let g:session_autosave = 'yes'
    " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
    "let g:session_autoload = 'yes'
    " 1分間に1回自動保存
    " let g:session_autosave_periodic = 1
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endfunction
  " 現在のディレクトリ直下の .vimsessions/ を取得
  let s:local_session_directory =
        \ xolox#misc#path#merge(getcwd(), '.vimsessions')
  let s:global_session_directory = expand('~/.vim/sessions')

  if isdirectory(s:local_session_directory)
    call s:session_config(s:local_session_directory)
  elseif isdirectory(s:global_session_directory)
    call s:session_config(s:global_session_directory)
  else
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endif
  unlet s:local_session_directory
  unlet s:global_session_directory
endif

"-------------------------------
" tagbar
if s:plug.is_installed('tagbar')
  " highlight link TagbarHighlight PmenuSel
  let g:tagbar_type_markdown = {
        \ 'ctagstype': 'markdown',
        \ 'ctagsbin' : 'markdown2ctags',
        \ 'ctagsargs' : '-f - --sort=yes',
        \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
        \ ],
        \ 'sro' : '|',
        \ 'kind2scope' : {
        \ 's' : 'section',
        \ },
        \ 'sort': 0,
        \ }
endif

"-------------------------------
" vim-bbye
if s:plug.is_installed('vim-bbye')
  nnoremap <Leader>bd :Bdelete<CR>
  nmap <F4> :Bdelete<CR>
  nmap <C-X> :Bdelete<CR>
  nmap <S-F4> :Bdelete!<CR>
  nmap <C-F4> :Bdelete!<CR>
endif

"-------------------------------
" accelerated-jk
if s:plug.is_installed('accelerated-jk')
  let g:accelerated_jk_acceleration_table = [30,60,80,85,90,95,100]
  nmap <expr> j v:count ? '<Plug>(accelerated_jk_j)' : '<Plug>(accelerated_jk_gj)'
  nmap <expr> k v:count ? '<Plug>(accelerated_jk_k)' : '<Plug>(accelerated_jk_gk)'
endif

"-------------------------------
" clever-f.vim
if s:plug.is_installed('clever-f.vim')
  let g:clever_f_ignore_case = 0
  let g:clever_f_across_no_line = 1
  let g:clever_f_fix_key_direction = 1
  "map ; <Plug>(clever-f-repeat-forward)
  "map , <Plug>(clever-f-repeat-back)
endif

"-------------------------------
" vim-buffergator
if s:plug.is_installed('vim-buffergator')
  let g:buffergator_viewport_split_policy = 'T'
  let g:buffergator_hsplit_size = 10
  let g:buffergator_suppress_keymaps = 1
  nmap <S-F12> :<C-u>BuffergatorToggle<CR>
  " nmap <S-F9> :<CR>
  " nmap <C-F9> :<CR>
  " nmap <C-S-F9> :<CR>
endif

"-------------------------------
" ferret
if s:plug.is_installed('ferret')
  let g:FerretMap = 0
endif

"-------------------------------
" python-mode
if s:plug.is_installed('python-mode')
  let g:pymode_folding = 0
  let g:pymode_rope_completion = 0
  let g:pymode_python = 'python3'
endif

"-------------------------------
" vim-operator-flashy
if s:plug.is_installed('vim-operator-flashy')
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
endif

"-------------------------------
" EnhancedJumps
if s:plug.is_installed('EnhancedJumps')
  nmap <S-F2> g<C-o>
  nmap <S-F3> g<C-i>
endif

"-------------------------------
" rust.vim
if s:plug.is_installed('rust.vim')
  let g:rustfmt_autosave = 1
  if executable('rustfmt')
    let g:rustfmt_command = 'rustfmt'
  elseif filereadable($HOME . '/.cargo/bin/rustfmt')
    let g:rustfmt_command = $HOME . '/.cargo/bin/rustfmt'
  elseif filereadable('/usr/bin/rustfmt')
    let g:rustfmt_command = '/usr/bin/rustfmt'
  endif
  let g:rust_clip_command = 'xclip -selection clipboard'
endif

"-------------------------------
" rust-doc.vim
if s:plug.is_installed('rust-doc.vim')
  let g:rust_doc#define_map_K = 0
  augroup vimrc_rust_doc
    autocmd!
    autocmd FileType rust nnoremap <buffer><silent><C-S-F1> :<C-u>RustDocsCurrentWord<CR>
  augroup END
endif

"-------------------------------
" vim-go
if s:plug.is_installed('vim-go')
  let g:go_fmt_command = 'goimports'
  let g:go_hightlight_functions = 1
  let g:go_hightlight_methods = 1
  let g:go_hightlight_structs = 1
  let g:go_hightlight_interfaces = 1
  let g:go_hightlight_operators = 1
  let g:go_hightlight_build_constraints = 1
endif

"-------------------------------
" is.vim
if s:plug.is_installed('is.vim')
  if s:plug.is_installed('vim-anzu')
    map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
    map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
  endif
  if s:plug.is_installed('vim-asterisk')
    map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
    map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
    map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
    map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
  endif
endif

"-------------------------------
" vim-edgemotion
if s:plug.is_installed('vim-edgemotion')
  map <Leader>j <Plug>(edgemotion-j)
  map <Leader>k <Plug>(edgemotion-k)
endif

"-------------------------------
" ale
if s:plug.is_installed('ale')
  let g:ale_completion_enabled = 0
  let g:ale_rust_cargo_use_clippy = 1
  let g:ale_set_loclist = 0
endif

"-------------------------------
" delimitMate
if s:plug.is_installed('delimitMate')
  let delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
  let delimitMate_smart_matchpairs = '^\%(\S\|\!\|[£$]\|[^[:space:][:punct:]]\)'
endif

"-------------------------------
" vim-table-mode
if s:plug.is_installed('vim-table-mode')
  let g:table_mode_corner = '|'
endif

"-------------------------------
" vim-sonictemplate
if s:plug.is_installed('vim-sonictemplate')
  let g:sonictemplate_vim_template_dir = ['~/.vim/template']
endif

"-------------------------------
" vim-dirvish
if s:plug.is_installed('vim-dirvish')
  let g:dirvish_mode = ':sort r /[^\/]$/'
endif

"-------------------------------
" vim-markdown
if s:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
  let g:markdown_enable_mappings = 0
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_no_default_key_mappings = 1
endif

"-------------------------------
" vim-startify.vim
if s:plug.is_installed('vim-startify')
  if filereadable(expand('~/.vim/rc/files/startify_custom_header.txt'))
    let g:startify_custom_header = startify#fortune#boxed() +
          \ readfile(expand('~/.vim/rc/files/startify_custom_header.txt'))
  endif
  let g:startify_custom_footer = ['', '                                 powered by vim-startify', '']
  let g:startify_session_dir = '~/.vim/sessions'

  let g:startify_commands = [
        \ {'m': ['Memo', 'MemoNew tmp']},
        \ {'l': ['MemoList', 'MemoListSort']},
        \ {'i': ['PlugInstall', 'PlugInstall']},
        \ {'u': ['PlugUpdate', 'PlugUpdate']},
        \ ]
endif

"-------------------------------
" vim-polyglot
if s:plug.is_installed('vim-polyglot')
  let g:csv_no_conceal = 0
  autocmd! filetypedetect * *.tmux
endif

"-------------------------------
" cohama/lexima.vim
if s:plug.is_installed('lexima.vim')
  function! s:lexima_my_settings() abort
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '(', 'input': '('})
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '[', 'input': '['})
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '"', 'input': '"'})
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '''', 'input': ''''})
    call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '`', 'input': '`'})
    call lexima#add_rule({'at': '\%#\n\s*}', 'char': '}', 'input': '}', 'delete': '}'})
  endfunction

  augroup vimrc_lexima
    autocmd!
    autocmd VimEnter * call s:lexima_my_settings()
  augroup END
endif

"-------------------------------
" vim-terraform
if s:plug.is_installed('vim-terraform')
  let g:terraform_fmt_on_save = 1
endif

"-------------------------------
" vim-test
if s:plug.is_installed('vim-test')
  let g:test#strategy = 'asyncrun'
  nnoremap <make>   <Nop>
  nmap    m <make>
  nnoremap <make>n :<C-u>TestNearest<CR>
  nnoremap <make>f :<C-u>TestFile<CR>
  nnoremap <make>s :<C-u>TestSuite<CR>
  nnoremap <make>l :<C-u>TestLast<CR>
  nnoremap <make>v :<C-u>TestVisit<CR>
  let g:test#rust#cargotest#options = '-- --nocapture'
  let g:test#rust#cargotest#executable = 'RUST_BACKTRACE=1 cargo test'

  command! TestCurrent wa <Bar> execute 'TestNearest ' . get(b:, 'vista_nearest_method_or_function', '')
  nnoremap <make>c :<C-u>TestCurrent<CR>
endif

"-------------------------------
" asynctasks.vim
if s:plug.is_installed('asynctasks.vim')
endif

"-------------------------------
" asyncrun.vim
if s:plug.is_installed('asyncrun.vim')
  let g:asyncrun_open = 8
  " https://github.com/skywind3000/asyncrun.vim/blob/58d23e70569994b36208ed2a653f0a2d75c24fbc/doc/asyncrun.txt#L181
  augroup vimrc_asyncrun
    autocmd!
    autocmd User AsyncRunStop copen | $ | wincmd p
  augroup END
endif

"-------------------------------
" vim-dispatch
if s:plug.is_installed('vim-dispatch')
  nnoremap <Leader>R :<C-u>Copen<Bar>Dispatch<CR>
  " nnoremap <SubLeader>q   :<C-u>Copen<CR>
  nnoremap <make><CR> :<C-u>Make
endif

"-------------------------------
" vim-better-whitespace
if s:plug.is_installed('vim-better-whitespace')
  let g:better_whitespace_enabled = 1
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'minimap']
endif

"-------------------------------
" vim-cheatsheet
if s:plug.is_installed('vim-cheatsheet')
  let s:cache_file_dir = expand('~/.cache/vim/files/')
  if !isdirectory(s:cache_file_dir)
    call system('mkdir -p ' . s:cache_file_dir)
  endif
  let g:cheatsheet#cheat_file = expand(s:cache_file_dir . 'cheatsheet.md')
  command! CheatUpdate call system("curl -Ls https://raw.githubusercontent.com/yutakatay/katapedia/master/doc/Vim.md -o " . g:cheatsheet#cheat_file)
endif

"-------------------------------
" vim-matchup
if s:plug.is_installed('vim-matchup')
  let g:loaded_matchit = 1
  hi MatchParenCur cterm=underline gui=underline
  hi MatchWordCur cterm=underline gui=underline
endif

"-------------------------------
" vim-gutentags
if s:plug.is_installed('vim-gutentags')
  let g:gutentags_enabled = 0
  let g:gutentags_add_default_project_roots = 0
  let g:gutentags_project_root  = ['package.json', '.git', '.hg', '.svn']
  let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
  let g:gutentags_generate_on_new = 1
  let g:gutentags_generate_on_missing = 1
  let g:gutentags_generate_on_write = 1
  let g:gutentags_generate_on_empty_buffer = 0
  let g:gutentags_ctags_extra_args = ['--tag-relative=yes', '--fields=+ailmnS']
  let g:gutentags_ctags_exclude = [
        \  '*.git', '*.svn', '*.hg',
        \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
        \  '*-lock.json',  '*.lock',
        \  '*.min.*',
        \  '*.bak',
        \  '*.zip',
        \  '*.pyc',
        \  '*.class',
        \  '*.sln',
        \  '*.csproj', '*.csproj.user',
        \  '*.tmp',
        \  '*.cache',
        \  '*.vscode',
        \  '*.pdb',
        \  '*.exe', '*.dll', '*.bin',
        \  '*.mp3', '*.ogg', '*.flac',
        \  '*.swp', '*.swo',
        \  '.DS_Store', '*.plist',
        \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
        \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
        \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
        \]

  let g:gutentags_enabled = 1
  let g:gutentags_modules = []
  if executable('ctags')
    let g:gutentags_modules += ['ctags']
  endif
  if executable('cscope')
    let g:gutentags_modules += ['cscope']
  endif
  if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
  endif
  let g:gutentags_cache_dir = expand('~/.cache/tags')
  if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, 'p')
  endif
  let g:gutentags_gtags_dbpath = g:gutentags_cache_dir
  let g:gutentags_define_advanced_commands = 1

  function! s:SetupCPPTags()
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    let g:gutentags_ctags_extra_args += ['/usr/include', '/usr/local/include']
  endfunction

  " lazy load for vim-plug
  " command! GutentagsSetup call gutentags#setup_gutentags()
  augroup vimrc_gutentags
    autocmd!
    " autocmd! User vim-gutentags call gutentags#setup_gutentags()
    autocmd! FileType c,cpp call <SID>SetupCPPTags()
  augroup END
endif

"-------------------------------
" gutentags_plus
if s:plug.is_installed('gutentags_plus')
  let g:gutentags_plus_nomap = 1
endif

"-------------------------------
" memolist.vim
if s:plug.is_installed('memolist.vim')
  let g:memolist_path = $HOME . '/.memo'
  let g:memolist_memo_suffix = 'md'
  let g:memolist_fzf = 1
  command! MemoListSort call fzf#run(fzf#wrap({'source': "find " . g:memolist_path . " -type f -printf '%T@ %p\n' | sort -k 1 -nr | sed 's/^[^ ]* //'"}))
endif

"-------------------------------
" vim-illuminate
if s:plug.is_installed('vim-illuminate')
  let g:Illuminate_ftblacklist = ['nerdtree']
endif

"-------------------------------
" repmo-vim
if s:plug.is_installed('repmo-vim')
  map <expr> , repmo#LastKey(';')|sunmap ,
endif

"-------------------------------
" quick-scope
if s:plug.is_installed('quick-scope')
  nmap <leader>qs <plug>(QuickScopeToggle)
  xmap <leader>qs <plug>(QuickScopeToggle)
  let g:qs_max_chars = 100
  let g:qs_lazy_highlight = 1
  set updatetime=100
  augroup vimrc_quick_scope
    autocmd!
    autocmd FileType nerdtree,buffergator,tagbar,qf let b:qs_local_disable=1
  augroup END
endif

"-------------------------------
" operator-camelize.vim
if s:plug.is_installed('operator-camelize.vim')
  vnoremap <SubLeader>c <Plug>(operator-camelize)
  vnoremap <SubLeader>C <Plug>(operator-decamelize)
endif

"-------------------------------
" vim-operator-convert-case
if s:plug.is_installed('vim-operator-convert-case')
  nmap <SubLeader>cc <Plug>(operator-convert-case-loop)iw
  vmap <SubLeader>cc <Plug>(operator-convert-case-loop)gv
endif

"-------------------------------
" vim-operator-replace
if s:plug.is_installed('vim-operator-replace')
  map U <Plug>(operator-replace)
endif


"-------------------------------
" fzf-mru.vim
if s:plug.is_installed('fzf-mru.vim')
  let g:fzf_mru_relative = 0
  nnoremap <Leader>; :<C-u>FZFMru<CR>
endif

"-------------------------------
" fzf-filemru
if s:plug.is_installed('fzf-filemru')
  augroup vimrc_fzf_filemru
    autocmd!
    autocmd BufEnter * UpdateMru
  augroup END
  let g:fzf_filemru_git_ls = 1
  function! s:fzf_file_mru_without_find(args) abort
    let l:fzf_default_tmp = $FZF_DEFAULT_COMMAND
    let $FZF_DEFAULT_COMMAND = ':'
    execute a:args
    let $FZF_DEFAULT_COMMAND = l:fzf_default_tmp
  endfunction
  command! -nargs=* FZFFileMru FilesMru
  command! -nargs=* FZFProjectMru call s:fzf_file_mru_without_find('ProjectMru')
  command! -nargs=* -bang FZFUpdateMru call s:fzf_file_mru_without_find('UpdateMru')
  nnoremap <Leader>. :<C-u>FZFFileMru<CR>
  nnoremap <Leader>p :<C-u>FZFProjectMru<CR>
endif

"-------------------------------
" vim-qf
if s:plug.is_installed('vim-qf')
  nmap <LocalLeader>q <Plug>(qf_qf_toggle_stay)
  nmap <LocalLeader>l <Plug>(qf_loc_toggle_stay)
endif

"-------------------------------
" spelunker.vim
if s:plug.is_installed('spelunker.vim')
  let g:enable_spelunker_vim = 1
  " override
  command! AddCorrectSpell execute "normal Zg"
  command! AddWrongSpell  execute "normal Zw"
  command! ChangeCorrectSpell  execute ':call feedkeys("Z=")'
  command! FixCorrectSpell  execute ':ChangeCorrectSpell'
  command! CorrectSpell  execute ':ChangeCorrectSpell'
endif

"-------------------------------
" vista.vim
if s:plug.is_installed('vista.vim')
  " Position to open the vista sidebar. On the right by default.
  " Change to 'vertical topleft' to open on the left.
  let g:vista_sidebar_position = 'vertical botright'
  " Width of vista sidebar.
  let g:vista_sidebar_width = 30
  " Set this flag to 0 to disable echoing when the cursor moves.
  let g:vista_echo_cursor = 1
  " Time delay for showing detailed symbol info at current cursor.
  let g:vista_cursor_delay = 400
  " Close the vista window automatically close when you jump to a symbol.
  let g:vista_close_on_jump = 0
  " Move to the vista window when it is opened.
  let g:vista_stay_on_open = 1
  " Blinking cursor 2 times with 100ms interval after jumping to the tag.
  let g:vista_blink = [2, 100]
  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  let g:vista_icon_indent = [' => ', ' |-']
  " Executive used when opening vista sidebar without specifying it.
  " Avaliable: 'coc', 'ctags'. 'ctags' by default.
  let g:vista_default_executive = 'ctags'
  let g:vista#executives = ['coc', 'ctags', 'lcn', 'vim_lsp']
  " Declare the command including the executable and options used to generate ctags output
  " for some certain filetypes.The file path will be appened to your custom command.
  " For example:
  let g:vista_ctags_cmd = {
        \ 'haskell': 'hasktags -o - -c',
        \ }
  " To enable fzf's preview window set g:vista_fzf_preview.
  " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
  " For example:
  let g:vista_fzf_preview = ['right:50%']
  " Fall back to other executives if the specified one gives empty data.
  " By default it's all the provided executives excluding the tried one.
  " let g:vista_finder_alternative_executives = ['coc']
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  function! MyRunForNearestMethodOrFunction() abort
    if line2byte('$') + len(getline('$')) < 1000000
      call vista#RunForNearestMethodOrFunction()
    endif
  endfunction

  nmap <Leader>v :<C-u>Vista finder<CR>

  augroup vimrc_vista
    autocmd!
    autocmd VimEnter * call MyRunForNearestMethodOrFunction()
  augroup END
endif

"-------------------------------
" asyncomplete.vim
if s:plug.is_installed('asyncomplete.vim')
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  let g:asyncomplete_remove_duplicates = 1
  let g:asyncomplete_smart_completion = 1
  let g:asyncomplete_auto_popup = 1
  set completeopt+=preview
  augroup vimrc_asynccomplete
    autocmd!
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  augroup END
endif

"-------------------------------
" vim-xtabline
if s:plug.is_installed('vim-xtabline')
  " let g:xtabline_lazy = 1
  let g:xtabline_settings = {}
  let g:xtabline_settings.tabline_modes = ['buffers', 'tabs', 'arglist']
  let g:xtabline_settings.buffer_filtering = 0
  let g:xtabline_settings.relative_paths = 0
  let g:xtabline_settings.use_tab_cwd = 0
  let g:xtabline_settings.theme = 'codedark'
  let g:xtabline_settings.map_prefix = 'm'
  " let g:xtabline_settings.enable_mappings = 1
  let g:xtabline_settings.bufline_format = ' N I< l +'
  let g:xtabline_settings.recent_buffers = 99
  let g:xtabline_settings.tab_number_in_buffers_mode = 0
  nmap <silent> <F2> :<C-u>if IsNormalBuffer() <Bar> execute "1XTabPrevBuffer" <Bar> endif <CR>
  nmap <silent> <F3> :<C-u>if IsNormalBuffer() <Bar> execute "1XTabNextBuffer" <Bar> endif <CR>
  nmap <silent> <C-a> :<C-u>if IsNormalBuffer() <Bar> execute "1XTabPrevBuffer" <Bar> endif <CR>
  nmap <silent> <C-g> :<C-u>if IsNormalBuffer() <Bar> execute "1XTabNextBuffer" <Bar> endif <CR>
  nmap <F4> :<C-u>XTabCloseBuffer<CR>
  nmap <C-x> :<C-u>XTabCloseBuffer<CR>
  nmap <S-F4> :<C-u>XTabCloseBuffer<CR>
  nmap <C-F4> :<C-u>XTabCloseBuffer<CR>
  nmap <C-M-F2> :<C-u>XTabMoveBufferPrev<CR>
  nmap <C-M-F3> :<C-u>XTabMoveBufferNext<CR>
  nmap <S-PageUp>   :<C-u>XTabMoveBufferPrev<CR>
  nmap <S-PageDown> :<C-u>XTabMoveBufferNext<CR>
  nmap <BS> <Plug>(XT-Select-Buffer)

  nmap <Leader>1 1<Plug>(XT-Select-Buffer)
  nmap <Leader>2 2<Plug>(XT-Select-Buffer)
  nmap <Leader>3 3<Plug>(XT-Select-Buffer)
  nmap <Leader>4 4<Plug>(XT-Select-Buffer)
  nmap <Leader>5 5<Plug>(XT-Select-Buffer)
  nmap <Leader>6 6<Plug>(XT-Select-Buffer)
  nmap <Leader>7 7<Plug>(XT-Select-Buffer)
  nmap <Leader>8 8<Plug>(XT-Select-Buffer)
  nmap <Leader>9 9<Plug>(XT-Select-Buffer)
  nmap <Leader>0 0<Plug>(XT-Select-Buffer)

  function! s:xtabline_ignore_buffer() abort
    if &ft ==? 'scrollbar'
      " setlocal buftype=
    endif
  endfunction

  function! s:xtabline_reformat() abort
    if winwidth(0) > 150
      let g:xtabline_settings.show_right_corner = 1
    else
      let g:xtabline_settings.show_right_corner = 0
    endif
  endfunction
  call s:xtabline_reformat()
  augroup vimrc_xtabline
    autocmd!
    autocmd VimResized * call s:xtabline_reformat() | call xtabline#cmds#run("reset_buffer")
    " autocmd BufNew * call s:xtabline_ignore_buffer()
  augroup END
endif

"-------------------------------
" open-browser
if s:plug.is_installed('open-browser.vim')
  command! OpenBrowserCurrent execute 'OpenBrowser ' . expand('<cWORD>')
endif

"-------------------------------
" suda.vim
if s:plug.is_installed('suda.vim')
  let g:suda_smart_edit = 1
endif

"-------------------------------
" float-preview.nvim
if s:plug.is_installed('float-preview.nvim')
  let g:float_preview#docked = 0
endif

"-------------------------------
" nvim-miniyank
if s:plug.is_installed('nvim-miniyank')
  let g:miniyank_filename = $HOME.'/.cache/miniyank.mpack'
  if exists('*trim')
    let s:miniyank_filename_size = trim(system('du ' . g:miniyank_filename . ' | cut -f1'))
    if s:miniyank_filename_size > 1000
      echom 'Remove large miniyank.mpack file: ' . s:miniyank_filename_size . '[KB]'
      call system('rm -f ' . g:miniyank_filename)
    endif
  endif
  let g:miniyank_maxitems = 100
  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)
  map <LocalLeader>p <Plug>(miniyank-startput)
  map <LocalLeader>P <Plug>(miniyank-startPut)
  nmap <C-p> <Plug>(miniyank-cycle)
  nmap <C-n> <Plug>(miniyank-cycleback)
endif

"-------------------------------
" defx.nvim
if s:plug.is_installed('defx.nvim')
  function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
          \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> c
          \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
          \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
          \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
          \ defx#do_action('open_directory')
    nnoremap <silent><buffer><expr> E
          \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
          \ defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> o
          \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> K
          \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
          \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
          \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
          \ defx#do_action('toggle_columns',
          \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
          \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
          \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
          \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
          \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
          \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
          \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
          \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
          \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
          \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
          \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
          \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Esc>
          \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
          \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
          \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
          \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
          \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
          \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
          \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
          \ defx#do_action('change_vim_cwd')
  endfunction
  command! DefxProject Defx -split=vertical -winwidth=30 -direction=topleft -toggle -resume
  nnoremap <F12> :<C-u>Vista!!<CR>:DefxProject<CR>

  augroup vimrc_defx
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
    autocmd VimEnter * sil! au! FileExplorer *
    autocmd BufEnter * if IsDir(expand('%')) | bd | exe 'Defx' | endif
  augroup END
endif

"-------------------------------
" fila.vim
if s:plug.is_installed('fila.vim')
  nnoremap <F12> :<C-u>Vista!!<CR>:Fila -drawer<CR>
endif

"-------------------------------
" vim-multiple-cursors
if s:plug.is_installed('vim-multiple-cursors')
  let g:multi_cursor_use_default_mapping=0
  nnoremap <multiple-cursors>   <Nop>
  nmap    C <multiple-cursors>
  let g:multi_cursor_start_word_key      = 'C'
  let g:multi_cursor_select_all_word_key = '<Leader>C'
  let g:multi_cursor_start_key           = 'gC'
  let g:multi_cursor_select_all_key      = 'g<Leader>C'
  let g:multi_cursor_next_key            = '<C-n>'
  let g:multi_cursor_prev_key            = '<C-p>'
  let g:multi_cursor_skip_key            = '<C-x>'
  let g:multi_cursor_quit_key            = '<Esc>'
endif

"-------------------------------
" winresizer
if s:plug.is_installed('winresizer')
  let g:winresizer_start_key = '<C-w><C-r>'
endif

"-------------------------------
" vim-peekaboo
if s:plug.is_installed('vim-peekaboo')
  let g:peekaboo_prefix = '<Leader>'
  let g:peekaboo_ins_prefix = '<C-x>'
endif

"-------------------------------
" vim-swap
if s:plug.is_installed('vim-swap')
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif

"-------------------------------
" vim-sandwich
if s:plug.is_installed('vim-sandwich')
  " use mappings sa, sd, sr
  xmap is <Plug>(textobj-sandwich-query-i)
  xmap as <Plug>(textobj-sandwich-query-a)
  omap is <Plug>(textobj-sandwich-query-i)
  omap as <Plug>(textobj-sandwich-query-a)
  xmap iss <Plug>(textobj-sandwich-auto-i)
  xmap ass <Plug>(textobj-sandwich-auto-a)
  omap iss <Plug>(textobj-sandwich-auto-i)
  omap ass <Plug>(textobj-sandwich-auto-a)
  xmap im <Plug>(textobj-sandwich-literal-query-i)
  xmap am <Plug>(textobj-sandwich-literal-query-a)
  omap im <Plug>(textobj-sandwich-literal-query-i)
  omap am <Plug>(textobj-sandwich-literal-query-a)

  if s:plug.is_installed('vim-textobj-functioncall')
    let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
    " ycino's generics
    let g:sandwich#recipes += [
          \ {
          \   'buns': ['InputGenerics()', '">"'],
          \   'expr': 1,
          \   'cursor': 'inner_tail',
          \   'kind': ['add', 'replace'],
          \   'action': ['add'],
          \   'input': ['g']
          \ },
          \ {
          \   'external': ['i<', "\<Plug>(textobj-functioncall-a)"],
          \   'noremap': 0,
          \   'kind': ['delete', 'replace', 'query'],
          \   'input': ['g']
          \ },
          \ ]
    function! InputGenerics() abort
      let genericsname = input('Generics Name: ', '')
      if genericsname ==# ''
        throw 'OperatorSandwichCancel'
      endif
      return genericsname . '<'
    endfunction
  endif
endif

"-------------------------------
" vim-textobj-functioncall
if s:plug.is_installed('vim-textobj-functioncall')
  let g:textobj_functioncall_no_default_key_mappings = 1
  xmap iF <Plug>(textobj-functioncall-i)
  omap iF <Plug>(textobj-functioncall-i)
  xmap aF <Plug>(textobj-functioncall-a)
  omap aF <Plug>(textobj-functioncall-a)
endif

"-------------------------------
" quickr-preview.vim
if s:plug.is_installed('quickr-preview.vim')
  let g:quickr_preview_keymaps = 0
endif

"-------------------------------
" vim-clap
if s:plug.is_installed('vim-clap')
  function! s:clap_my_keymap() abort
    inoremap <silent> <buffer> <Down> <C-R>=clap#handler#navigate_result('down')<CR>
    inoremap <silent> <buffer> <Up> <C-R>=clap#handler#navigate_result('up')<CR>
  endfunction
  augroup vimrc_clap
    autocmd!
    autocmd User ClapOnEnter   call s:clap_my_keymap()
    " autocmd User ClapOnExit    call YourFunction()
  augroup END
  nnoremap <unique><silent> <Leader><Leader>bc :<C-u>Clap bcommits<CR>
  nnoremap <unique><silent> <Leader><Leader>l :<C-u>Clap blines<CR>
  nnoremap <unique><silent> <Leader><Leader>b :<C-u>Clap buffers<CR>
  " nnoremap <unique><silent> <Leader><Leader> :<C-u>Clap colors<CR>
  nnoremap <unique><silent> <Leader><Leader>h :<C-u>Clap hist<CR>
  nnoremap <unique><silent> <Leader><Leader>c :<C-u>Clap commits<CR>
  nnoremap <unique><silent> <Leader><Leader>f :<C-u>Clap files<CR>
  " nnoremap <unique><silent> <Leader><Leader> :<C-u>Clap filetypes<CR>
  nnoremap <unique><silent> <Leader><Leader>p :<C-u>Clap git_files<CR>
  nnoremap <unique><silent> <Leader><Leader>g :<C-u>Clap grep<CR>
  nnoremap <unique><silent> <Leader><Leader>j :<C-u>Clap jumps<CR>
  nnoremap <unique><silent> <Leader><Leader>m :<C-u>Clap marks<CR>
  nnoremap <unique><silent> <Leader><Leader>t :<C-u>Clap tags<CR>
  " nnoremap <unique><silent> <Leader><Leader> :<C-u>Clap windows<CR>
endif

"-------------------------------
" vim-toggle-quickfix
if s:plug.is_installed('vim-toggle-quickfix')
  nmap <SubLeader>q <Plug>window:quickfix:toggle
  nmap <SubLeader>l <Plug>window:location:toggle
endif

"-------------------------------
" vim-qfstatusline
if s:plug.is_installed('vim-qfstatusline')
  let g:Qfstatusline#UpdateCmd = function('lightline#update')
endif

"-------------------------------
" rainbow_csv
if s:plug.is_installed('rainbow_csv')
  let g:disable_rainbow_key_mappings = 1
endif

"-------------------------------
" vim-subversive
if s:plug.is_installed('vim-subversive')
  nmap <Leader>s <plug>(SubversiveSubstituteRange)
  xmap <Leader>s <plug>(SubversiveSubstituteRange)
  nmap <Leader>ss <plug>(SubversiveSubstituteWordRange)
endif

"-------------------------------
" vim-yoink
if s:plug.is_installed('vim-yoink')
  nmap <C-n> <plug>(YoinkPostPasteSwapBack)
  nmap <C-p> <plug>(YoinkPostPasteSwapForward)
  nmap p <plug>(YoinkPaste_p)
  nmap P <plug>(YoinkPaste_P)
endif

"-------------------------------
" git-messenger.vim
if s:plug.is_installed('git-messenger.vim')
  nmap <C-w>m <Plug>(git-messenger)
  function! s:setup_gitmessengerpopup() abort
    nmap <buffer><Esc> q
  endfunction
  augroup vimrc_git_messenger
    autocmd FileType gitmessengerpopup call <SID>setup_gitmessengerpopup()
  augroup END
endif

"-------------------------------
" vim-clurin
if s:plug.is_installed('vim-clurin')
  nmap + <Plug>(clurin-next)
  nmap _ <Plug>(clurin-prev)
  vmap + <Plug>(clurin-next)
  vmap _ <Plug>(clurin-prev)
endif

"-------------------------------
" GoldenView.Vim
if s:plug.is_installed('GoldenView.Vim')
  let g:goldenview__enable_default_mapping = 0
  let g:goldenview__enable_at_startup = 0
endif

"-------------------------------
" context.vim
if s:plug.is_installed('context.vim')
  let g:context_enabled = 0
  let g:context_add_mappings = 0
endif

"-------------------------------
" vim-which-key
if s:plug.is_installed('vim-which-key')
  nnoremap <silent> <Leader><CR>      :<C-u>WhichKey '<lt>Space>'<CR>
  nnoremap <silent> <SubLeader><CR> :<C-u>WhichKey  '<SubLeader>'<CR>
  nnoremap <silent> <Leader>f :<C-u>WhichKey '<lt>Space>f'<CR>
  nnoremap <silent> <make><CR> :<C-u>WhichKey  '<make>'<CR>
  nnoremap <silent> <spector><CR> :<C-u>WhichKey  '<spector>'<CR>
  nnoremap <silent> <fzf-p><CR> :<C-u>WhichKey  '<fzf-p>'<CR>
  nnoremap <silent> <fzf-p-resume><CR> :<C-u>WhichKey  '<fzf-p-resume>'<CR>
  nnoremap <silent> <coc><CR> :<C-u>WhichKey  '<coc>'<CR>
  nnoremap <silent> <easymotion><CR> :<C-u>WhichKey  '<easymotion>'<CR>
  nnoremap <silent> g<CR> :<C-u>WhichKey  'g'<CR>
endif

"-------------------------------
" CommentFrame.vim
if s:plug.is_installed('CommentFrame.vim')
  let g:CommentFrame_SkipDefaultMappings = 1
endif

"-------------------------------
" fern.vim
if s:plug.is_installed('fern.vim')
  augroup vimrc_fern
    autocmd!
    autocmd VimEnter * sil! au! FileExplorer *
    autocmd BufEnter * ++nested call s:hijack_directory()
  augroup END
  function! s:hijack_directory() abort
    let path = expand('%')
    if !isdirectory(path)
      return
    endif
    exe 'Fern' path
  endfunction
endif

"-------------------------------
" any-jump.vim
if s:plug.is_installed('any-jump.vim')
  let g:any_jump_disable_default_keybindings = 1
  " Normal mode: Jump to definition under cursore
  nnoremap ]j :AnyJump<CR>
  " Visual mode: jump to selected text in visual mode
  xnoremap ]j :AnyJumpVisual<CR>
  " Normal mode: open previous opened file (after jump)
  nnoremap ]b :AnyJumpBack<CR>
  " Normal mode: open last closed search window again
  nnoremap ]l :AnyJumpLastResults<CR>
endif

"-------------------------------
" gen_tags.vim
if s:plug.is_installed('gen_tags.vim')
  if !executable('ctags')
    let g:gen_tags#ctags_auto_gen = 1
  endif
  if !executable('gtags')
    let g:loaded_gentags#gtags = 1
  endif
  let g:gen_tags#gtags_default_map = 0
endif

"-------------------------------
" vim-columnmove
if s:plug.is_installed('vim-columnmove')
  let g:columnmove_no_default_key_mappings = 1
  nmap      J       <Plug>(columnmove-w)
  xmap      J       <Plug>(columnmove-w)
  omap      J       <Plug>(columnmove-w)
  omap     vJ      v<Plug>(columnmove-w)
  omap     VJ      V<Plug>(columnmove-w)
  omap <C-v>J  <C-v><Plug>(columnmove-w)
  nmap      K      <Plug>(columnmove-b)
  xmap      K      <Plug>(columnmove-b)
  omap      K      <Plug>(columnmove-b)
  omap     vK     v<Plug>(columnmove-b)
  omap     VK     V<Plug>(columnmove-b)
  omap <C-v>K  <C-v><Plug>(columnmove-b)
endif

"-------------------------------
" columnskip.vim
if s:plug.is_installed('columnskip.vim')
  nmap sj <Plug>(columnskip-j)
  omap sj <Plug>(columnskip-j)
  xmap sj <Plug>(columnskip-j)
  nmap sk <Plug>(columnskip-k)
  omap sk <Plug>(columnskip-k)
  xmap sk <Plug>(columnskip-k)
endif

"-------------------------------
" vim-highlightedundo
if s:plug.is_installed('vim-highlightedundo')
  nmap u     <Plug>(highlightedundo-undo)
  nmap <C-r> <Plug>(highlightedundo-redo)
  " nmap U     <Plug>(highlightedundo-Undo)
  nmap g-    <Plug>(highlightedundo-gminus)
  nmap g+    <Plug>(highlightedundo-gplus)
endif

"-------------------------------
" vimspector
if s:plug.is_installed('vimspector')
  " do not use a/d/r(sandwich), j/k(columnmove)
  nnoremap <spector>   <Nop>
  nmap    s <spector>
  command! SpectorLaunch call vimspector#Launch()
  command! SpectorStop VimspectorReset
  nmap <spector>c  <Plug>VimspectorContinue
  nmap <spector>q  <Plug>VimspectorStop
  nmap <spector>t  <Plug>VimspectorRestart
  nmap <spector>,  <Plug>VimspectorPause
  nmap <spector>b  <Plug>VimspectorToggleBreakpoint
  nmap <spector>f  <Plug>VimspectorAddFunctionBreakpoint
  nmap <spector>n  <Plug>VimspectorStepOver
  nmap <spector>i  <Plug>VimspectorStepInto
  nmap <spector>o  <Plug>VimspectorStepOut
endif

"-------------------------------
" vim-submode
if s:plug.is_installed('vim-submode')
  let g:submode_timeout = v:true
  let g:submode_timeoutlen = 800
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>+')
  call submode#map('winsize', 'n', '', '-', '<C-w>-')
endif

"-------------------------------
" vim-bookmarks
if s:plug.is_installed('vim-bookmarks')
  nmap <SubLeader>m <Plug>BookmarkToggle
  let g:bookmark_no_default_key_mappings = 1
endif

"-------------------------------
" vim-textobj-between
if s:plug.is_installed('vim-textobj-between')
  omap i/ <Plug>(textobj-between-i)/
  omap a/ <Plug>(textobj-between-a)/
  xmap i/ <Plug>(textobj-between-i)/
  xmap a/ <Plug>(textobj-between-a)/
  omap i_ <Plug>(textobj-between-i)_
  omap a_ <Plug>(textobj-between-a)_
  xmap i_ <Plug>(textobj-between-i)_
  xmap a_ <Plug>(textobj-between-a)_
  omap i- <Plug>(textobj-between-i)-
  omap a- <Plug>(textobj-between-a)-
  xmap i- <Plug>(textobj-between-i)-
  xmap a- <Plug>(textobj-between-a)-
  omap i<Space> <Plug>(textobj-between-i)<Space>
  omap a<Space> <Plug>(textobj-between-a)<Space>
  xmap i<Space> <Plug>(textobj-between-i)<Space>
  xmap a<Space> <Plug>(textobj-between-a)<Space>
endif

"-------------------------------
" nvim-treesitter
if s:plug.is_installed('nvim-treesitter')
  nmap <SubLeader>e :<C-u>e!<CR>
  execute "lua require'pluginconfig/nvim-treesitter'"
endif

"-------------------------------
" vim-litecorrect
if s:plug.is_installed('vim-litecorrect')
  augroup vimrc_litecorrect
    autocmd!
    autocmd FileType markdown,mkd call litecorrect#init()
  augroup END
endif

"-------------------------------
" vim-autocorrect
if s:plug.is_installed('vim-autocorrect')
  augroup vimrc_autocorrect
    autocmd!
    autocmd FileType markdown,mkd call AutoCorrect()
  augroup END
endif

"-------------------------------
" wilder.nvim
if s:plug.is_installed('wilder.nvim')
  call wilder#enable_cmdline_enter()
  set wildcharm=<Tab>
  cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
  cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
  " nnoremap <expr> <Leader>w wilder#toggle()
  command! WilderToggle call wilder#toggle()

  call wilder#disable()

  " only / and ? is enabled by default
  call wilder#set_option('modes', ['/', '?', ':'])
  let s:hl = 'LightlineMiddle_active'
  let s:mode_hl = 'LightlineLeft_active_0'
  let s:index_hl = 'LightlineRight_active_0'

  function! FilterCocList(ctx, res) abort
    let l:parsed = wilder#cmdline#parse(a:ctx.input)
    if l:parsed.cmd ==# 'CocList'
      let l:arg = l:parsed.cmdline[l:parsed.pos :]
      return extend(a:res, {
            \ 'value': filter(a:res.value, {i, x -> match(x, l:arg) != -1}),
            \ 'data': extend(get(a:res, 'data', {}), {'query': l:arg})
            \ })
    endif
    return a:res
  endfunction

  call wilder#set_option('pipeline', wilder#branch(
        \ wilder#python_search_pipeline(),
        \ wilder#cmdline_pipeline() + [funcref('FilterCocList')]
        \ ))
  " call wilder#set_option('pipeline', [
  "       \   wilder#branch(
  "       \     [
  "       \       wilder#check({_, x -> empty(x)}),
  "       \       wilder#history(),
  "       \     ],
  "       \     wilder#vim_search_pipeline(),
  "       \     wilder#cmdline_pipeline({
  "       \       'fuzzy': 1,
  "       \       'use_python': 1,
  "       \     }),
  "       \     wilder#python_search_pipeline({
  "       \       'regex': 'fuzzy',
  "       \       'engine': 're',
  "       \       'sort': function('wilder#python_sort_difflib'),
  "       \     }),
  "       \   ),
  "       \ ])
  call wilder#set_option('renderer', wilder#wildmenu_renderer({
        \ 'highlights': {
        \   'default': s:hl,
        \ },
        \ 'apply_highlights': wilder#query_common_subsequence_spans(),
        \ 'separator': '  ',
        \ 'left': [{'value': [
        \    wilder#condition(
        \      {-> getcmdtype() ==# ':'},
        \      ' COMMAND ',
        \      ' SEARCH ',
        \    ),
        \    wilder#condition(
        \      {ctx, x -> has_key(ctx, 'error')},
        \      '!',
        \      wilder#spinner({
        \        'frames': '-\|/',
        \        'done': '',
        \      }),
        \    ), ' ',
        \ ], 'hl': s:mode_hl,},
        \ wilder#separator('', s:mode_hl, s:hl, 'left'), ' ',
        \ ],
        \ 'right': [
        \    ' ', wilder#separator('', s:index_hl, s:hl, 'right'),
        \    wilder#index({'hl': s:index_hl}),
        \ ],
        \ }))

endif

"-------------------------------
" vim-wordmotion
if s:plug.is_installed('vim-wordmotion')
  let g:wordmotion_prefix = '<SubLeader>'
endif

"-------------------------------
" vim-print-debug
if s:plug.is_installed('vim-print-debug')
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
endif

"-------------------------------
" vim-quickui
if s:plug.is_installed('vim-quickui')
  call quickui#menu#reset()

  call quickui#menu#install('&File', [
        \ [ '&Open\t(:w)', 'call feedkeys(":tabe ")'],
        \ [ '&Save\t(:w)', 'write'],
        \ [ '--', ],
        \ [ 'LeaderF &File', 'Leaderf file', 'Open file with leaderf'],
        \ [ 'LeaderF &Mru', 'Leaderf mru --regexMode', 'Open recently accessed files'],
        \ [ 'LeaderF &Buffer', 'Leaderf buffer', 'List current buffers in leaderf'],
        \ [ '--', ],
        \ [ 'J&unk File', 'JunkFile', ''],
        \ ])

  if has('win32') || has('win64') || has('win16')
    call quickui#menu#install('&File', [
          \ [ '--', ],
          \ [ 'Start &Cmd', 'silent !start /b cmd /C c:\drivers\clink\clink.cmd' ],
          \ [ 'Start &PowerShell', 'silent !start powershell.exe' ],
          \ [ 'Open &Explore', 'call Show_Explore()' ],
          \ ])
  endif

  call quickui#menu#install('&File', [
        \ [ '--', ],
        \ [ 'E&xit', 'qa' ],
        \ ])

  call quickui#menu#install('&Edit', [
        \ ['Copyright &Header', 'call feedkeys("\<esc> ec")', 'Insert copyright information at the beginning'],
        \ ['&Trailing Space', 'call StripTrailingWhitespace()', ''],
        \ ['Update &ModTime', 'call UpdateLastModified()', ''],
        \ ['&Paste Mode Line', 'PasteVimModeLine', ''],
        \ ['Format J&son', '%!python -m json.tool', ''],
        \ ['--'],
        \ ['&Align Table', 'Tabularize /|', ''],
        \ ['Align &Cheatsheet', 'MyCheatSheetAlign', ''],
        \ ])

  call quickui#menu#install('&Symbol', [
        \ [ '&Grep Word\t(In Project)', 'call MenuHelp_GrepCode()', 'Grep keyword in current project' ],
        \ [ '--', ],
        \ [ 'Find &Definition\t(GNU Global)', 'call MenuHelp_Gscope("g")', 'GNU Global search g'],
        \ [ 'Find &Symbol\t(GNU Global)', 'call MenuHelp_Gscope("s")', 'GNU Gloal search s'],
        \ [ 'Find &Called by\t(GNU Global)', 'call MenuHelp_Gscope("d")', 'GNU Global search d'],
        \ [ 'Find C&alling\t(GNU Global)', 'call MenuHelp_Gscope("c")', 'GNU Global search c'],
        \ [ 'Find &From Ctags\t(GNU Global)', 'call MenuHelp_Gscope("z")', 'GNU Global search c'],
        \ [ '--', ],
        \ [ 'Goto D&efinition\t(YCM)', 'YcmCompleter GoToDefinitionElseDeclaration'],
        \ [ 'Goto &References\t(YCM)', 'YcmCompleter GoToReferences'],
        \ [ 'Get D&oc\t(YCM)', 'YcmCompleter GetDoc'],
        \ [ 'Get &Type\t(YCM)', 'YcmCompleter GetTypeImprecise'],
        \ ])

  call quickui#menu#install('&Move', [
        \ ['Quickfix &First\t:cfirst', 'cfirst', 'quickfix cursor rewind'],
        \ ['Quickfix L&ast\t:clast', 'clast', 'quickfix cursor to the end'],
        \ ['Quickfix &Next\t:cnext', 'cnext', 'cursor next'],
        \ ['Quickfix &Previous\t:cprev', 'cprev', 'quickfix cursor previous'],
        \ ])

  call quickui#menu#install('&Build', [
        \ ['File &Execute\tF5', 'AsyncTask file-run'],
        \ ['File &Compile\tF9', 'AsyncTask file-build'],
        \ ['File E&make\tF7', 'AsyncTask emake'],
        \ ['File &Start\tF8', 'AsyncTask emake-exe'],
        \ ['--', ''],
        \ ['&Project Build\tShift+F9', 'AsyncTask project-build'],
        \ ['Project &Run\tShift+F5', 'AsyncTask project-run'],
        \ ['Project &Test\tShift+F6', 'AsyncTask project-test'],
        \ ['Project &Init\tShift+F7', 'AsyncTask project-init'],
        \ ['--', ''],
        \ ['T&ask List\tCtrl+F10', 'call MenuHelp_TaskList()'],
        \ ['E&dit Task', 'AsyncTask -e'],
        \ ['Edit &Global Task', 'AsyncTask -E'],
        \ ['&Stop Building', 'AsyncStop'],
        \ ])

  call quickui#menu#install('&Git', [
        \ ['&View Diff', 'call svnhelp#svn_diff("%")'],
        \ ['&Show Log', 'call svnhelp#svn_log("%")'],
        \ ['File &Add', 'call svnhelp#svn_add("%")'],
        \ ])

  if has('win32') || has('win64') || has('win16') || has('win95')
    call quickui#menu#install('&Git', [
          \ ['--',''],
          \ ['Project &Update\t(Tortoise)', 'call svnhelp#tp_update()', 'TortoiseGit / TortoiseSvn'],
          \ ['Project &Commit\t(Tortoise)', 'call svnhelp#tp_commit()', 'TortoiseGit / TortoiseSvn'],
          \ ['Project L&og\t(Tortoise)', 'call svnhelp#tp_log()',  'TortoiseGit / TortoiseSvn'],
          \ ['Project &Diff\t(Tortoise)', 'call svnhelp#tp_diff()', 'TortoiseGit / TortoiseSvn'],
          \ ['--',''],
          \ ['File &Add\t(Tortoise)', 'call svnhelp#tf_add()', 'TortoiseGit / TortoiseSvn'],
          \ ['File &Blame\t(Tortoise)', 'call svnhelp#tf_blame()', 'TortoiseGit / TortoiseSvn'],
          \ ['File Co&mmit\t(Tortoise)', 'call svnhelp#tf_commit()', 'TortoiseGit / TortoiseSvn'],
          \ ['File D&iff\t(Tortoise)', 'call svnhelp#tf_diff()', 'TortoiseGit / TortoiseSvn'],
          \ ['File &Revert\t(Tortoise)', 'call svnhelp#tf_revert()', 'TortoiseGit / TortoiseSvn'],
          \ ['File Lo&g\t(Tortoise)', 'call svnhelp#tf_log()', 'TortoiseGit / TortoiseSvn'],
          \ ])
  endif

  call quickui#menu#install('&Tools', [
        \ ['Compare &History', 'call svnhelp#compare_ask_file()', ''],
        \ ['&Compare Buffer', 'call svnhelp#compare_ask_buffer()', ''],
        \ ['--',''],
        \ ['List &Buffer', 'call quickui#tools#list_buffer("FileSwitch tabe")', ],
        \ ['List &Function', 'call quickui#tools#list_function()', ],
        \ ['Display &Messages', 'call quickui#tools#display_messages()', ],
        \ ['--',''],
        \ ["&DelimitMate %{get(b:, 'delimitMate_enabled', 0)? 'Disable':'Enable'}", 'DelimitMateSwitch'],
        \ ['Read &URL', 'call menu#ReadUrl()', 'load content from url into current buffer'],
        \ ['&Spell %{&spell? "Disable":"Enable"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
        \ ['&Profile Start', 'call MonitorInit()', ''],
        \ ['Profile S&top', 'call MonitorExit()', ''],
        \ ["Relati&ve number %{&relativenumber? 'OFF':'ON'}", 'set relativenumber!'],
        \ ['Proxy &Enable', 'call MenuHelp_Proxy(1)', 'setup http_proxy/https_proxy/all_proxy'],
        \ ['Proxy D&isable', 'call MenuHelp_Proxy(0)', 'clear http_proxy/https_proxy/all_proxy'],
        \ ])

  call quickui#menu#install('&Plugin', [
        \ ['&NERDTree\t<space>tn', 'NERDTreeToggle', 'toggle nerdtree'],
        \ ['&Tagbar', '', 'toggle tagbar'],
        \ ['&Choose Window/Tab\tAlt+e', 'ChooseWin', 'fast switch win/tab with vim-choosewin'],
        \ ['-'],
        \ ['&Browse in github\trhubarb', 'Gbrowse', "using tpope's rhubarb to open browse and view the file"],
        \ ['&Startify', 'Startify', "using tpope's rhubarb to open browse and view the file"],
        \ ['&Gist', 'Gist', 'open gist with mattn/gist-vim'],
        \ ['&Edit Note', 'Note', 'edit note with vim-notes'],
        \ ['&Display Calendar', 'Calendar', 'display a calender'],
        \ ['Toggle &Vista', 'Vista!!', ''],
        \ ['-'],
        \ ['Plugin &List', 'PlugList', 'Update list'],
        \ ['Plugin &Update', 'PlugUpdate', 'Update plugin'],
        \ ])

  call quickui#menu#install('Help (&?)', [
        \ ['&Index', 'tab help index', ''],
        \ ['Ti&ps', 'tab help tips', ''],
        \ ['--',''],
        \ ['&Tutorial', 'tab help tutor', ''],
        \ ['&Quick Reference', 'tab help quickref', ''],
        \ ['&Summary', 'tab help summary', ''],
        \ ['--',''],
        \ ['&Vim Script', 'tab help eval', ''],
        \ ['&Function List', 'tab help function-list', ''],
        \ ['&Dash Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
        \ ], 10000)

  " let g:quickui_show_tip = 1

  "----------------------------------------------------------------------
  " context menu
  "----------------------------------------------------------------------
  let g:context_menu_k = [
        \ ['&Peek Definition\tAlt+;', 'call quickui#tools#preview_tag("")'],
        \ ['S&earch in Project\t\\cx', 'exec "silent! GrepCode! " . expand("<cword>")'],
        \ [ '--', ],
        \ [ 'Find &Definition\t\\cg', 'call MenuHelp_Fscope("g")', 'GNU Global search g'],
        \ [ 'Find &Symbol\t\\cs', 'call MenuHelp_Fscope("s")', 'GNU Gloal search s'],
        \ [ 'Find &Called by\t\\cd', 'call MenuHelp_Fscope("d")', 'GNU Global search d'],
        \ [ 'Find C&alling\t\\cc', 'call MenuHelp_Fscope("c")', 'GNU Global search c'],
        \ [ 'Find &From Ctags\t\\cz', 'call MenuHelp_Fscope("z")', 'GNU Global search c'],
        \ [ '--', ],
        \ [ 'Goto D&efinition\t(YCM)', 'YcmCompleter GoToDefinitionElseDeclaration'],
        \ [ 'Goto &References\t(YCM)', 'YcmCompleter GoToReferences'],
        \ [ 'Get D&oc\t(YCM)', 'YcmCompleter GetDoc'],
        \ [ 'Get &Type\t(YCM)', 'YcmCompleter GetTypeImprecise'],
        \ [ '--', ],
        \ ['Dash &Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
        \ ['Cpp&man', 'exec "Cppman " . expand("<cword>")', '', 'c,cpp'],
        \ ['P&ython Doc', 'call quickui#tools#python_help("")', 'python'],
        \ ]

  "----------------------------------------------------------------------
  " hotkey
  "----------------------------------------------------------------------
  nnoremap <silent><F10> :call quickui#menu#open()<cr>
endif

"-------------------------------
" scrollbar.nvim
if s:plug.is_installed('scrollbar.nvim')
  augroup vimrc_scrollbar
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
    autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
  augroup END
endif

"-------------------------------
" cosco.vim
if s:plug.is_installed('cosco.vim')
  augroup vimrc_cosco
    autocmd!
    autocmd FileType javascript,css,rust,c,cpp,cs,java,php nmap <silent> <SubLeader>; <Plug>(cosco-commaOrSemiColon)
    autocmd FileType javascript,css,rust,c,cpp,cs,java,php imap <silent> <C-_> <c-o><Plug>(cosco-commaOrSemiColon)<Esc>o
  augroup END
endif

"-------------------------------
" targets.vim
if s:plug.is_installed('targets.vim')
  let g:targets_aiAI = ['<Space>a', '<Space>i', '<Space>A', '<Space>I']
endif

"-------------------------------
" vim-niceblock
if s:plug.is_installed('vim-niceblock')
  let g:niceblock_no_default_key_mappings = 0
  xmap I  <Plug>(niceblock-I)
  xmap gI  <Plug>(niceblock-gI)
endif

"-------------------------------
" barbar.nvim
if s:plug.is_installed('barbar.nvim')
  " Magic buffer-picking mode
  nnoremap <silent> <Space>b :BufferPick<CR>
  nnoremap <silent>    <F4> :BufferClose<CR>
  nnoremap <silent>    <C-X> :BufferClose<CR>
  nnoremap <silent>    <S-F4> :BufferClose<CR>
  nnoremap <silent>    <C-F4> :BufferClose<CR>
  " Move to previous/next
  nnoremap <silent>    <C-a> :BufferPrevious<CR>
  nnoremap <silent>    <C-g> :BufferNext<CR>
  " Re-order to previous/next
  nnoremap <silent>    <C-M-F2> :BufferMovePrevious<CR>
  nnoremap <silent>    <C-M-F3> :BufferMoveNext<CR>
  " Goto buffer in position...
  nnoremap <silent>    <Space>1 :BufferGoto 1<CR>
  nnoremap <silent>    <Space>2 :BufferGoto 2<CR>
  nnoremap <silent>    <Space>3 :BufferGoto 3<CR>
  nnoremap <silent>    <Space>4 :BufferGoto 4<CR>
  nnoremap <silent>    <Space>5 :BufferGoto 5<CR>
  nnoremap <silent>    <Space>6 :BufferGoto 6<CR>
  nnoremap <silent>    <Space>7 :BufferGoto 7<CR>
  nnoremap <silent>    <Space>8 :BufferGoto 8<CR>
  nnoremap <silent>    <Space>9 :BufferLast<CR>

  let bufferline = {}

  " Show a shadow over the editor in buffer-pick mode
  let bufferline.shadow = v:true

  " Enable/disable animations
  let bufferline.animation = v:true

  " Enable/disable icons
  let bufferline.icons = v:true

  " Enable/disable close button
  let bufferline.closable = v:false

  " Enables/disable clickable tabs
  "  - left-click: go to buffer
  "  - middle-click: delete buffer
  let bufferline.clickable = v:false

  " If set, the letters for each buffer in buffer-pick mode will be
  " assigned based on their name. Otherwise or in case all letters are
  " already assigned, the behavior is to assign letters in order of
  " usability (see order below)
  let bufferline.semantic_letters = v:true
endif

"-------------------------------
" mkdx
if s:plug.is_installed('mkdx')
  let g:mkdx#settings     = {
        \ 'highlight': { 'enable': 1 },
        \ 'enter': { 'shift': 1 },
        \ 'links': { 'external': { 'enable': 1 } },
        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
        \ }
endif

"-------------------------------
" nvim-treesitter-context
if s:plug.is_installed('nvim-treesitter-context')
  " autocmd VimEnter * execute "TSContextDisable"
endif

"-------------------------------
" you-are-here.vim
if s:plug.is_installed('you-are-here.vim')
  nnoremap <silent> <Leader>- :call you_are_here#Toggle()<CR>
endif

"-------------------------------
" vim-win
if s:plug.is_installed('vim-win')
  nmap <leader>- <plug>WinWin
  command Win :call win#Win()
  let g:win_ext_command_map = {"\<cr>": 'Win#exit'}
endif

"-------------------------------
" vim-move
if s:plug.is_installed('vim-move')
  let g:move_map_keys = 0
  vmap <C-j> <Plug>MoveBlockDown
  vmap <C-k> <Plug>MoveBlockUp
  vmap <C-h> <Plug>MoveBlockLeft
  vmap <C-l> <Plug>MoveBlockRight
endif

"-------------------------------
" aho-bakaup.vim
if s:plug.is_installed('aho-bakaup.vim')
  let g:bakaup_backup_dir = expand('~/.cache/vim_bakaup')
  let g:bakaup_auto_backup = 1
endif

"-------------------------------
" instant.nvim
if s:plug.is_installed('instant.nvim')
  lua vim.g.instant_username = os.getenv("USER")
endif

"-------------------------------
" vim-shfmt
if s:plug.is_installed('vim-shfmt')
  let g:shfmt_extra_args = '-i 2'
  let g:shfmt_fmt_on_save = 1
endif

"-------------------------------
" glepnir/indent-guides.nvim
if s:plug.is_installed('indent-guides.nvim')
  lua <<EOF
  require('indent_guides').default_opts = {
    indent_levels = 30;
    indent_guide_size = 0;
    indent_start_level = 1;
    indent_space_guides = true;
    indent_tab_guides = true;
    indent_pretty_guides = true;
    indent_soft_pattern = '\\s';
    exclude_filetypes = {'help'}
  }
EOF
endif

" }}}


" ---


"===============================
" lightline                  {{{
"===============================

if s:plug.is_installed('lightline.vim')
  let g:lightline = {
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 0,
        \ },
        \ 'component_function': {
        \   'git_branch': 'LightLineCocGitBranch',
        \   'git_status': 'LightLineCocGitStatus',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'quickfix_title': 'LightLineQuickfixTitle',
        \   'filesize': 'FileSizeForHuman',
        \   'mode': 'LightLineMode',
        \   'cocstatus': 'coc#status',
        \   'git_blame': 'LightLineCocGitBlame',
        \   'currentfunction': 'CocOrVistaCurrentFunction',
        \   'vista_method': 'NearestMethodOrFunction',
        \ },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }
  let s:lightline_mode1 = {
        \   'left': [
        \              ['mode', 'paste'],
        \              ['filename'],
        \              ['currentfunction', 'quickfix_title']
        \   ],
        \   'right': [
        \              ['lineinfo'],
        \              ['git_status'],
        \              ['cocstatus']
        \   ]
        \ }
  let s:lightline_mode2 = {
        \   'left': [
        \              ['mode', 'paste'],
        \              ['filename'],
        \              ['git_branch', 'git_blame'],
        \   ],
        \   'right': [
        \              ['lineinfo'],
        \              ['filesize', 'percent'],
        \              ['fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ }
  let g:lightline.active = s:lightline_mode1
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
  if exists('s:lightline_colorscheme')
    let g:lightline.colorscheme = s:lightline_colorscheme
  else
    let g:lightline.colorscheme = 'wombat'
  endif

  nnoremap <silent> ! :<C-u>call LightLineToggle()<CR>
  function! LightLineToggle() abort
    let g:lightline.active = g:lightline.active ==# s:lightline_mode1 ? s:lightline_mode2 : s:lightline_mode1
    call lightline#init()
    call lightline#update()
  endfunction

  function! LightLineModified() abort
    return &ft =~? 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightLineReadonly() abort
    return &ft !~? 'help' && &readonly ? 'RO' : ''
  endfunction

  function! LightLineMode() abort
    let fname = expand('%:t')
    return fname ==? '__vista__' ? 'Vista' :
          \ fname ==? '__Gundo__' ? 'Gundo' :
          \ fname ==? '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~? 'buffergator-buffers' ? 'BufferGator' :
          \ (&ft ==? 'qf' && getwininfo(win_getid())[0].loclist) ? 'Location' :
          \ &ft ==? 'qf' ? 'QuickFix' :
          \ &ft ==? 'defx' ? 'Defx' :
          \ &ft ==? 'coc-explorer' ? '' :
          \ winwidth(0) > 30 ? lightline#mode() : ''
  endfunction

  function! LightLineFilename() abort
    if winwidth(0) < 50
      let fname = expand('%:t')
    elseif winwidth(0) > 150
      let fname = expand('%')
    else
      let fname = pathshorten(expand('%'))
    endif
    return fname ==? '__vista__' ? '' :
          \ fname =~? '__Gundo\|NERD_tree' ? '' :
          \ &ft ==? 'qf' ? g:asyncrun_status :
          \ &ft ==? 'fern' ? 'Fern' :
          \ &ft ==? 'defx' ? 'Defx' :
          \ &ft ==? 'undotree' ? (exists('*t:undotree.GetStatusLine') ? t:undotree.GetStatusLine() : fname) :
          \ &ft ==? 'coc-explorer' ? 'coc-explorer' :
          \ ('' !=? LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
          \ ('' !=? fname ? fname : '[No Name]') .
          \ ('' !=? LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  function! LightLineQuickfixTitle() abort
    return exists('w:quickfix_title') ? w:quickfix_title : ''
  endfunction

  function! LightLineFugitive() abort
    try
      if &ft !~? 'help\|gundo\|diff' && exists('g:loaded_fugitive')
        let mark = ''  " edit here for cool mark
        let branch = fugitive#head()
        return branch !=# '' ? mark.branch : ''
      endif
    catch
    endtry
    return ''
  endfunction

  " function! LightLineGinaBranch()
  "   if &ft !~? 'help\|gundo\|diff' && exists('g:loaded_gina')
  "     return gina#component#repo#branch()
  "   endif
  "   return ''
  " endfunction

  " function! LightLineGinaStatus()
  "   if &ft !~? 'help\|gundo\|diff' && exists('g:loaded_gina')
  "     return gina#component#status#preset()
  "   endif
  "   return ''
  " endfunction

  function! LightLineFileformat() abort
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightLineFiletype() abort
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction

  function! LightLineFileencoding() abort
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
  endfunction

  augroup vimrc_gutentags_status_line_refresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
  augroup END

  function! LightLineCocGitBranch() abort
    return winwidth(0) > 90 ? get(g:,'coc_git_status','') : ''
  endfunction

  function! LightLineCocGitStatus() abort
    let l:status = substitute(
          \ substitute(get(b:, 'coc_git_status', ''), ' *', '', ''),
          \ ' *$', '', '')
    return winwidth(0) > 90 ? l:status : ''
  endfunction

  function! LightLineCocGitBlame() abort
    let l:blame = get(b:, 'coc_git_blame', '')
    if l:blame ==? 'File not indexed'
      let l:blame = ''
    endif
    return winwidth(0) > 90 ? l:blame : ''
  endfunction

  function! FileSizeForHuman() abort
    let l:bytes = line2byte('$') + len(getline('$'))
    let l:sizes = ['', 'K', 'M', 'G']
    let l:i = 0
    while l:bytes >= 1024
      let l:bytes = l:bytes / 1024.0
      let l:i += 1
    endwhile
    return printf('%.1f%s', l:bytes, l:sizes[l:i])
  endfun

  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
  set noshowmode

  function! SwitchLightlineColorScheme(color) abort
    let g:lightline.colorscheme = a:color
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endfunction

  function! CocCurrentFunction() abort
    return get(b:, 'coc_current_function', '')
  endfunction

  function! CocOrVistaCurrentFunction() abort
    let l:func_name = get(b:, 'coc_current_function', '')
    if l:func_name ==? ''
      return get(b:, 'vista_nearest_method_or_function', '')
    endif
    return l:func_name
  endfunction

  "-------------------------------
  " Disable configs
  " syntastic
  "      \ 'component_expand': {
  "      \   'syntastic': 'SyntasticStatuslineFlag',
  "      \ },
  "      \ 'component_type': {
  "      \   'syntastic': 'error',
  "      \ },

  " augroup vimrc_syntastic
  " autocmd!
  " autocmd BufWritePost *.c,*.cpp,*.cc call s:syntastic()
  " augroup END
  " function! s:syntastic() abort
  " SyntasticCheck
  " call lightline#update()
  " endfunction

  " function! LightLineGitGutter() abort
  "   if ! exists('*GitGutterGetHunkSummary')
  "         \ || ! get(g:, 'gitgutter_enabled', 0)
  "         \ || winwidth('.') <= 90
  "     return ''
  "   endif
  "   let symbols = [
  "         \ g:gitgutter_sign_added . ' ',
  "         \ g:gitgutter_sign_modified . ' ',
  "         \ g:gitgutter_sign_removed . ' '
  "         \ ]
  "   let hunks = GitGutterGetHunkSummary()
  "   let ret = []
  "   for i in [0, 1, 2]
  "     if hunks[i] > 0
  "       call add(ret, symbols[i] . hunks[i])
  "     endif
  "   endfor
  "   return join(ret, ' ')
  " endfunction

  " let g:tagbar_status_func = 'TagbarStatusFunc'
  "
  " function! TagbarStatusFunc(current, sort, fname, ...) abort
  "   let g:lightline.fname = a:fname
  "   return lightline#statusline(0)
  " endfunction

  " function! LightLineFugitive() abort
  "   try
  "     if s:is_ignore_status()
  "       let mark = ''  " edit here for cool mark
  "       let branch = fugitive#head()
  "       return branch !=# '' ? mark.branch : ''
  "     endif
  "   catch
  "   endtry
  "   return ''
  " endfunction

  " function! CtrlPMark() abort
  "   if expand('%:t') =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item')
  "     call lightline#link('iR'[g:lightline.ctrlp_regex])
  "     return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
  "           \ , g:lightline.ctrlp_next], 0)
  "   else
  "     return ''
  "   endif
  " endfunction

  " let g:ctrlp_status_func = {
  "       \ 'main': 'CtrlPStatusFunc_1',
  "       \ 'prog': 'CtrlPStatusFunc_2',
  "       \ }
  "
  " function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) abort
  "   let g:lightline.ctrlp_regex = a:regex
  "   let g:lightline.ctrlp_prev = a:prev
  "   let g:lightline.ctrlp_item = a:item
  "   let g:lightline.ctrlp_next = a:next
  "   return lightline#statusline(0)
  " endfunction
  "
  " function! CtrlPStatusFunc_2(str) abort
  "   return lightline#statusline(0)
  " endfunction

  " function! AleError() abort
  "   return s:ale_string(0)
  " endfunction
  "
  " function! AleWarning() abort
  "   return s:ale_string(1)
  " endfunction
  "
  " function! AleOk() abort
  "   return s:ale_string(2)
  " endfunction
  "
  " function! s:ale_string(mode) abort
  "   if !exists('g:ale_buffer_info')
  "     return ''
  "   endif
  "
  "   let g:ale_statusline_format = ['Err' .' %d', 'Warn' . ' %d', 'OK' . '  ']
  "
  "   let l:buffer = bufnr('%')
  "   let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)
  "   let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
  "
  "   if a:mode == 0 " Error
  "     return l:error_count ? printf(l:error_format, l:error_count) : ''
  "   elseif a:mode == 1 " Warning
  "     return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
  "   endif
  "
  "   return l:error_count == 0 && l:warning_count == 0 ? l:no_errors : ''
  " endfunction
  "
  " augroup vimrc_lightline_on_ale
  "   autocmd!
  "   autocmd User ALELint call lightline#update()
  " augroup END

endif

" }}}


"===============================
" vim-ref                    {{{
"===============================

if s:plug.is_installed('vim-ref')
  function! RefDoc() abort
    if &filetype =~? 'perl'
      execute 'Ref perldoc'
    elseif &filetype =~? 'python'
      execute 'Ref pydoc'
    elseif &filetype =~? 'ruby'
      execute 'Ref refe'
    elseif &filetype =~? 'cpp'
      if has('nvim')
        execute 'terminal cppman ' .expand('<cword>')
      else
        execute '!cppman ' .expand('<cword>')
      endif
    elseif &filetype =~? 'go'
      execute 'GoDoc'
    else
      execute 'Ref man'
    endif
  endfunction
  map <F1> :<C-u>call RefDoc()<CR>

  let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
  let g:ref_lynx_use_cache = 1

  let g:ref_source_webdict_sites = {
        \   'weblio' : {
        \     'url' : 'https://ejje.weblio.jp/content/%s'
        \   },
        \   'wikij': {
        \     'url': 'https://ja.wikipedia.org/wiki/%s',
        \   },
        \   'wiki': {
        \     'url': 'https://en.wikipedia.org/wiki/%s',
        \   },
        \   'github': {
        \     'url': 'https://github.com/%s',
        \   },
        \   'github_raw': {
        \     'url': 'https://raw.githubusercontent.com/%s',
        \   },
        \   'docs_rs': {
        \     'url': 'https://docs.rs/%s',
        \   },
        \   'crates_io': {
        \     'url': 'https://crates.io/search?q=%s',
        \   },
        \ }
  function! g:ref_source_webdict_sites.weblio.filter(output) abort
    return join(split(a:output, "\n")[24 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.wiki.filter(output) abort
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.docs_rs.filter(output) abort
    return join(split(a:output, "\n")[14 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.crates_io.filter(output) abort
    return join(split(a:output, "\n")[14 :], "\n")
  endfunction

  let g:ref_source_webdict_sites.default = 'weblio'
  nnoremap <silent><expr> <Leader>re ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
  vnoremap <silent> <Leader>re "zy:Ref webdict weblio <C-r>"<CR>
  nnoremap <silent><expr> <Leader>rwj ':Ref webdict wikij ' . expand('<cword>') . '<CR>'
  vnoremap <silent> <Leader>rwj "zy:Ref webdict wikij <C-r>"<CR>
  nnoremap <silent><expr> <Leader>rw ':Ref webdict wiki ' . expand('<cword>') . '<CR>'
  vnoremap <silent> <Leader>rw "zy:Ref webdict wiki <C-r>"<CR>

  nnoremap <silent><expr> <S-F1> ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
  vnoremap <silent> <S-F1> "zy:Ref webdict weblio <C-r>"<CR>
  nnoremap <silent><expr> <C-F1> ':Ref webdict wiki ' . expand('<cword>') . '<CR>'

  command! WeblioCurrentWord execute 'Ref webdict weblio ' . expand('<cword>')
  command! -nargs=1 Weblioj execute 'Ref webdict weblio ' '<args>'
  command! -nargs=1 Weblioe execute 'Ref webdict weblio ' '<args>'
  command! Wikij execute 'Ref webdict wikij ' . expand('<cword>')
  command! Wiki execute 'Ref webdict wiki ' . expand('<cword>')

  " GitHub
  command! GitHubReadMe execute 'Ref webdict github_raw ' . expand('<cWORD>')[1:-2] . '/master/README.md'

  " Rust
  command! RustDocsCurrentWord execute 'Ref webdict docs_rs ' . expand('<cword>')
  command! -nargs=1 RustDocs execute 'Ref webdict docs_rs ' '<args>'
  " don't work because this site requires javascript
  " command! RustCratesIOCurrentWord execute 'Ref webdict crates_io ' . expand('<cword>')
  " command! -nargs=1 RustCratesIO execute 'Ref webdict crates_io ' '<args>'
endif

" }}}


"===============================
" fzf.vim                    {{{
"===============================

if s:plug.is_installed('fzf.vim')
  let g:fzf_command_prefix = 'FZF'

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }

  augroup vimrc_fzf
    autocmd!
    autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>
  augroup END

  command! -bar -bang FZFMapsN call fzf#vim#maps("n", <bang>0)
  command! -bar -bang FZFMapsI call fzf#vim#maps("i", <bang>0)
  command! -bar -bang FZFMapsX call fzf#vim#maps("x", <bang>0)
  command! -bar -bang FZFMapsO call fzf#vim#maps("o", <bang>0)
  command! -bar -bang FZFMapsV call fzf#vim#maps("v", <bang>0)
endif

" }}}


"===============================
" coc.nvim                   {{{
"===============================

if s:plug.is_installed('coc.nvim')
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.

  if s:plug.is_installed('lexima.vim')
    " do not imap <CR> ! because endwise do not work.
  else
    if exists('*complete_info')
      inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif
  endif

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " <C-w>p switch floating window

  " Use K to show documentation in preview window
  nnoremap <silent> Q :call <SID>show_documentation()<CR>

  function! s:show_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " sync coc_global_extensions with enable/disable
  function! s:sync_coc_global_extensions() abort
    let coc_extensions = CocAction('extensionStats')
    for e in coc_extensions
      if index(g:coc_global_extensions, e['id']) >= 0
        if e['state'] ==? 'disabled'
          call CocActionAsync('toggleExtension', e['id'])
        endif
      else
        if e['state'] !=? 'disabled'
          call CocActionAsync('toggleExtension', e['id'])
        endif
      endif
    endfor
  endfunction

  function! s:set_tag_func() abort
    " create too heavy tags file
    set tagfunc=CocTagFunc
    for tags_file in tagfiles()
      echom tags_file
      if filereadable(tags_file)
        set tagfunc=
        break
      endif
    endfor
  endfunction

  augroup vimrc_coc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json,jsonc setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd BufWritePre *.py Format
    " auto hover
    " autocmd CursorHold * if ! coc#util#has_float() | call CocAction('doHover') | endif
    " https://github.com/neoclide/coc.nvim/issues/1013
    " autocmd FileType vim if bufname('%') == '[Command Line]' | let b:coc_suggest_disable = 1 | endif
    autocmd User CocNvimInit call s:sync_coc_global_extensions()
    autocmd User CocNvimInit call s:set_tag_func()
  augroup END

  nnoremap <coc>   <Nop>
  nmap    ; <coc>
  " Remap for rename current word
  nmap <coc>r <Plug>(coc-rename)
  " Remap for format selected region
  xmap <coc>f  <Plug>(coc-format-selected)
  nmap <coc>f  <Plug>(coc-format-selected)
  " Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
  xmap <coc>as  <Plug>(coc-codeaction-selected)
  nmap <coc>as  <Plug>(coc-codeaction-selected)
  " Remap for do codeAction of current line
  nmap <coc>ac <Plug>(coc-codeaction)
  nma M <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <coc>q <Plug>(coc-fix-current)
  nmap <coc>l <Plug>(coc-codelens-action)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap <coc>if <Plug>(coc-funcobj-i)
  xmap <coc>af <Plug>(coc-funcobj-a)
  omap <coc>if <Plug>(coc-funcobj-i)
  omap <coc>af <Plug>(coc-funcobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  " Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
  nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

  " NeoVim-only mapping for visual mode scroll
  " Useful on signatureHelp after jump placeholder of snippet expansion
  if has('nvim')
    vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
    vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format call CocAction('format')
  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold call     CocAction('fold', <f-args>)

  " Using CocList
  nnoremap <silent> <coc>m  :<C-u>CocList<cr>
  " Show all diagnostics
  nnoremap <silent> <coc>d  :<C-u>CocDiagnostics<cr>
  nnoremap <silent> <coc>D  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <coc>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <coc>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <coc>o  :<C-u>CocList outline<cr>
  " Search workLeader symbols
  nnoremap <silent> <coc>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <coc>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <coc>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <coc>p  :<C-u>CocListResume<CR>

  command! CocInstallAll CocInstall -sync
  command! CocUninstallAll call s:coc_uninstall_all()

  function! s:coc_plugin_is_installed(name) abort
    let extensions = get(g:, 'coc_global_extensions', {})
    return (count(extensions, a:name) != 0)
  endfunction

  function! s:coc_uninstall_all() abort
    for e in g:coc_global_extensions
      execute 'CocUninstall ' . e
    endfor
  endfunction


  "----------------
  " Config
  call coc#config('coc.preferences.currentFunctionSymbolAutoUpdate', 'true')
  call coc#config('diagnostic-languageserver.filetypes', {
        \ 'vim': 'vint',
        \ 'markdown': [ 'write-good', 'markdownlint' ],
        \ 'sh': 'shellcheck',
        \ })
  call coc#config('list.insertMappings', {
        \ '<C-v>': 'action:vsplit',
        \ '<C-s>': 'action:split',
        \ '<C-w>': 'command:wincmd k'
        \ })
  call coc#config('rust-analyzer', {
        \ 'cargo-watch.enable': 'true',
        \ 'cargo-watch.command': 'clippy',
        \ 'cargo-watch.allTargets': 'true'
        \ })
  " uncaughtException Error: write EPIPE
  "call coc#config('git.addGBlameToBufferVar', 'true')
  call coc#config('python.jediEnabled', 'false')
  call coc#config('emmet.includeLanguages', {
        \ 'vue-html': 'html',
        \ 'javascript': 'javascriptreact'
        \ })
  call coc#config('yank.enableCompletion', 'false')
  call coc#config('snippets', {
        \ 'userSnippetsDirectory': '~/.vim/snippets/',
        \ 'snipmate.enable': 'false',
        \ 'convertToSnippetsAction': 'false'
        \ })
  call coc#config('explorer.icon.enableNerdfont', 'true')
  call coc#config('codeLens.enable', 'true')
  call coc#config('tabnine.priority', 50)
  call coc#config('cSpell.showStatus', 'false')
  call coc#config('translator', {
        \ 'toLang': 'ja',
        \ 'engines': [
        \   'google',
        \   'bing'
        \ ]})

  if executable('efm-langserver')
    call coc#config('languageserver.efm', {
          \ 'command': 'efm-langserver',
          \ 'args': [],
          \ 'filetypes': ['vim', 'eruby', 'markdown', 'yaml', 'sh']
          \})
    "   // custom config path
    "   // 'args': ['-c', '/path/to/your/config.yaml'],
  endif


  "----------------
  " Plugins
  if s:coc_plugin_is_installed('coc-snippets')
    imap <C-l> <Plug>(coc-snippets-expand)
    " vmap <C-k> <Plug>(coc-snippets-select)
    let g:coc_snippet_next = '<c-s>'
    let g:coc_snippet_prev = '<c-t>'
    imap <C-s> <Plug>(coc-snippets-expand-jump)
    " inoremap <silent><expr> <TAB>
    "       \ pumvisible() ? coc#_select_confirm() :
    "       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "       \ <SID>check_back_space() ? "\<TAB>" :
    "       \ coc#refresh()
  endif

  if s:coc_plugin_is_installed('coc-yank')
    highlight HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A
    nnoremap <silent> <Leader>y  :<C-u>CocList -A --normal yank<cr>
  endif

  if s:coc_plugin_is_installed('coc-git')
    " navigate chunks of current buffer
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    " show chunk diff at current position
    nmap gs <Plug>(coc-git-chunkinfo)
    " show commit contains current position
    nmap <coc>gc <Plug>(coc-git-commit)
  endif

  if s:coc_plugin_is_installed('coc-pairs')
    augroup vimrc_coc_pairs
      autocmd!
      autocmd FileType vim let b:coc_pairs_disabled = ['"']
    augroup END
  endif

  if s:coc_plugin_is_installed('coc-highlight')
    augroup vimrc_coc_highlight
      autocmd!
      autocmd CursorHold * silent call CocActionAsync('highlight')
    augroup END
  endif

  if s:coc_plugin_is_installed('coc-explorer')
    nmap gx :<C-u>CocCommand explorer --width 30<CR>

    augroup vimrc_coc_explorer
      autocmd!
      autocmd VimEnter * sil! au! FileExplorer *
      autocmd BufEnter * let s:d = expand('%:p') | if IsDir(s:d) | bd | exe 'CocCommand explorer ' . s:d | endif
    augroup END
  endif

  if s:coc_plugin_is_installed('coc-spell-checker')
    command! CSpellAddWordToWorkspaceDictionary CocCommand cSpell.addWordToDictionary
  endif

  if s:coc_plugin_is_installed('coc-actions')
    function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> <coc>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <coc>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
    xmap <silent> M :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> M   :<C-u>execute 'CocCommand actions.open'<CR>
  endif

  if s:coc_plugin_is_installed('coc-translator')
    nmap <coc>t <Plug>(coc-translator-p)
    vmap <coc>t <Plug>(coc-translator-pv)
  endif

  if s:coc_plugin_is_installed('coc-floatinput')
    nmap <silent> <coc>: <Plug>(coc-floatinput-command)
    nmap <silent> <coc>:c <Plug>(coc-floatinput-coc-command)
    nmap <silent> <coc>rn <Plug>(coc-floatinput-rename)
  endif

  if s:coc_plugin_is_installed('coc-fzf-preview')
    function! s:buffers_delete_from_lines(lines) abort
      for line in a:lines
        let matches = matchlist(line, '\[\(\d\+\)\]')
        if len(matches) >= 1
          execute 'Bdelete! ' . matches[1]
        endif
      endfor
    endfunction

    function! s:fzf_preview_settings() abort
      let g:fzf_preview_command = 'bat --color=always --style=grid,header {-1}'
      " let g:fzf_preview_fzf_preview_window_option = 'wrap'
      let g:fzf_preview_filelist_command = 'rg --files --hidden --no-messages -g \!"* *" -g \!".git"'
      if s:plug.is_installed('vim-devicons')
        let g:fzf_preview_use_dev_icons = 1
      endif
      let g:fzf_preview_quit_map = 1

      let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file', 'coc')
      let g:fzf_preview_custom_processes['open-file']['ctrl-s'] = g:fzf_preview_custom_processes['open-file']['ctrl-x']
      call remove(g:fzf_preview_custom_processes['open-file'], 'ctrl-x')

      let g:fzf_preview_custom_processes['open-buffer'] = fzf_preview#remote#process#get_default_processes('open-buffer', 'coc')
      let g:fzf_preview_custom_processes['open-buffer']['ctrl-s'] = g:fzf_preview_custom_processes['open-buffer']['ctrl-x']
      call remove(g:fzf_preview_custom_processes['open-buffer'], 'ctrl-q')
      let g:fzf_preview_custom_processes['open-buffer']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')

      let g:fzf_preview_custom_processes['open-bufnr'] = fzf_preview#remote#process#get_default_processes('open-bufnr', 'coc')
      let g:fzf_preview_custom_processes['open-bufnr']['ctrl-s'] = g:fzf_preview_custom_processes['open-bufnr']['ctrl-x']
      call remove(g:fzf_preview_custom_processes['open-bufnr'], 'ctrl-q')
      let g:fzf_preview_custom_processes['open-bufnr']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')

      let g:fzf_preview_dev_icons_limit = 5000
      " let g:fzf_preview_default_fzf_options = { '--reverse': v:true }
    endfunction

    augroup vimrc_fzf_preview
      autocmd!
      autocmd User fzf_preview#initialized call s:fzf_preview_settings()
    augroup END

    " conflict coc-fzf
    " let g:fzf_layout = {
    "       \ 'window': 'call fzf_preview#window#create_centered_floating_window()',
    "       \ }

    " Map
    nnoremap <fzf-p>   <Nop>
    vnoremap <fzf-p>   <Nop>
    nmap    z <fzf-p>
    vmap    z <fzf-p>

    xnoremap          <CR>         "sy:CocCommand fzf-preview.ProjectGrep<Space>-F<Space><C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>
    nnoremap <silent> <Leader>p    :<C-u>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <Leader>.    :<C-u>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <Leader>;    :<C-u>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <Leader>'    :<C-u>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>,             :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    nnoremap <silent> <fzf-p>p     :<C-u>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p>.     :<C-u>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p>;     :<C-u>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p>'     :<C-u>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right<CR>
    nnoremap          <fzf-p>,     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    vnoremap          <fzf-p>,     y:<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=escape(@", '\\.*$^[]')<CR>"
    nnoremap <silent> <fzf-p>g     :<C-u>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p><C-g> :<C-u>CocCommand fzf-preview.GitActions --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <Leader>g     :<C-u>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <Leader><C-g> :<C-u>CocCommand fzf-preview.GitActions --add-fzf-arg=--keep-right<CR>
    "nnoremap <silent> <fzf-p>b     :<C-u>CocCommand fzf-preview.Buffers<CR>
    nnoremap <silent> <fzf-p>b     :<C-u>CocCommand fzf-preview.Buffers --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p>a     :<C-u>CocCommand fzf-preview.AllBuffers --add-fzf-arg=--keep-right<CR>
    nnoremap <silent> <fzf-p>m     :<C-u>CocCommand fzf-preview.Marks<CR>
    nnoremap          <Leader>*    :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
    nnoremap <silent> <Leader>/    :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'" --resume<CR>
    nnoremap          <Leader><Leader>*  :<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=expand('<cword>')<CR>"
    nnoremap          <fzf-p>*     :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
    nnoremap <silent> <fzf-p>/     :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
    nnoremap          <fzf-p>**    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=expand('<cword>')<CR>"
    nnoremap <silent> <fzf-p><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
    nnoremap <silent> <fzf-p>j     :<C-u>CocCommand fzf-preview.Jumps<CR>
    nnoremap <silent> <fzf-p>c     :<C-u>CocCommand fzf-preview.Changes<CR>
    nnoremap <silent> <fzf-p>t     :<C-u>CocCommand fzf-preview.Ctags<CR>
    nnoremap <silent> <fzf-p>tb    :<C-u>CocCommand fzf-preview.BufferTags --resume<CR>
    nnoremap <silent> <fzf-p>q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
    nnoremap <silent> <fzf-p>l     :<C-u>CocCommand fzf-preview.LocationList<CR>
    nnoremap          <Leader>gf   :<C-u>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--select-1 --add-fzf-arg=--query="<C-r>=substitute(expand('<cfile>'), '^\.\+/', '', '')<CR>"<CR>

    nnoremap <silent> <fzf-p>v     :<C-u>CocCommand fzf-preview.VistaCtags<CR>
    nnoremap <silent> <fzf-p>vb    :<C-u>CocCommand fzf-preview.VistaBufferCtags<CR>
    nnoremap <silent> <fzf-p>r     :<C-u>CocCommand fzf-preview.CocReferences<CR>
    nnoremap <silent> <fzf-p>d     :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>
    nnoremap <silent> <fzf-p>c     :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
    nnoremap <silent> <fzf-p>n     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
    nnoremap <silent> <fzf-p>h     :<C-u>CocCommand fzf-preview.CommandPalette<CR>

    " resume
    nnoremap <fzf-p-resume>   <Nop>
    vnoremap <fzf-p-resume>   <Nop>
    nmap    Z <fzf-p-resume>
    vmap    Z <fzf-p-resume>
    nnoremap <silent> <Leader>P    :<C-u>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <Leader>>    :<C-u>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <Leader>:    :<C-u>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <Leader>"    :<C-u>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <Leader>,             :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    nnoremap <silent> <fzf-p-resume>p     :<C-u>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>.     :<C-u>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>;     :<C-u>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>'     :<C-u>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap          <fzf-p-resume>,     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    vnoremap          <fzf-p-resume>.     y:<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=escape(@", '\\.*$^[]') --resume<CR>"
    nnoremap <silent> <fzf-p-resume>g     :<C-u>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>b     :<C-u>CocCommand fzf-preview.Buffers --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>a     :<C-u>CocCommand fzf-preview.AllBuffers --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>m     :<C-u>CocCommand fzf-preview.Marks --resume<CR>
    nnoremap <silent> <fzf-p-resume>w     :<C-u>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>g     :<C-u>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <silent> <fzf-p-resume>j     :<C-u>CocCommand fzf-preview.Jumps --resume<CR>
    nnoremap <silent> <fzf-p-resume>c     :<C-u>CocCommand fzf-preview.Changes --resume<CR>
    nnoremap <silent> <fzf-p-resume>t     :<C-u>CocCommand fzf-preview.Ctags --resume<CR>
    nnoremap <silent> <fzf-p-resume>tb    :<C-u>CocCommand fzf-preview.BufferTags --resume --resume<CR>
    nnoremap <silent> <fzf-p-resume>q     :<C-u>CocCommand fzf-preview.QuickFix --resume<CR>
    nnoremap <silent> <fzf-p-resume>l     :<C-u>CocCommand fzf-preview.LocationList --resume<CR>
    nnoremap <silent> <fzf-p-resume>n     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>

    " Command
    command! -bang FZFTodo FzfPreviewProjectGrep FIXME\|TODO<CR>
  endif

  if s:plug.is_installed('coc-fzf')
    call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'FZFBuffers')
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
  endif

endif

" }}}


" ------------------------------


"===============================================================
"          Disable Plugin Settings                           {{{
"===============================================================

""-------------------------------
"" hybrid
"if s:plug.is_installed('vim-hybrid')
"  let s:lightline_colorscheme = 'wombat'
"  set background=dark
"  colorscheme hybrid
"endif
" fzf.vim
" else
"
"   function! FzfOmniFiles()
"     let is_git = system('git status')
"     if v:shell_error
"       :FZFFiles
"     else
"       :FZFGFiles
"     endif
"   endfunction
"   nnoremap <Leader>p :<C-u>call FzfOmniFiles()<CR>
"   nnoremap <Leader>f; :<C-u>FZF<CR>
"   nnoremap <Leader>. :<C-u>FZF<CR>
"   nnoremap <Leader>ag :<C-u>FZFAg <C-R>=expand("<cword>")<CR><CR>
"   nnoremap <Leader>rg :<C-u>FZFRg <C-R>=expand("<cword>")<CR><CR>
"   nnoremap <Leader>fb :<C-u>FZFBuffers<CR>
"   nnoremap <Leader>fc :<C-u>FZFCommands<CR>
"
"   command! FZFOmniFiles call FzfOmniFiles()
"   command! FZFMruSimple call fzf#run({
"         \ 'source':  reverse(s:all_files()),
"         \ 'sink':    'edit',
"         \ 'options': '-m -x +s',
"         \ 'down':    '40%' })
"
"   function! s:all_files() abort
"     return extend(
"           \ filter(copy(v:oldfiles),
"           \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
"           \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
"   endfunction
"   nnoremap <Leader>; :<C-u>FZFMruSimple<CR>
"   command! -bang -nargs=* GGrep
"         \ call fzf#vim#grep(
"         \   'git grep --line-number '.shellescape(<q-args>), 0,
"         \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0]  }), <bang>0 )
"
"   command! -bang -nargs=* FZFGrep
"         \  call fzf#vim#grep('grep --line-number --ignore-case --recursive --exclude=".git/*" --color="always" '.shellescape(<q-args>), 0, <bang>0)
"   function! s:fzf_unite_grep(args) abort
"     if executable('rg')
"       execute 'FZFRg ' . a:args
"     elseif executable('ag')
"       execute 'FZFAg ' . a:args
"     else
"       execute 'FZFGrep ' . a:args
"     endif
"   endfunction
"   nmap <Leader>, :<C-u>FZFSearch<Space>
"   command! -bang -nargs=* FZFSearch call s:fzf_unite_grep(<q-args>)
"   command! -bang FZFTodo FZFSearch FIXME|TODO<CR>
"
"   let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all --preview
"         \ "
"         \ if [[ $(file --mime {}) =~ /directory ]]; then
"         \   echo {} is a directory;
"         \ elif [[ $(file --mime {}) =~ binary ]]; then
"         \   echo {} is a binary file;
"         \ elif [[ {} == *:* ]]; then
"         \   f=$(echo {} | cut -d : -f 1); n=$(echo {} | cut -d : -f 2) &&
"         \    ((bat --color=always --style=grid $f ||
"         \      highlight -O ansi -l $f ||
"         \      coderay $f ||
"         \      rougify $f ||
"         \     tail +$n $f) 2> /dev/null | tail +$n | head -500);
"         \ elif [[ -e $(echo {} | cut -d \" \" -f 2 2> /dev/null) ]]; then
"         \   f=$(echo {} | cut -d \" \" -f 2);
"         \    ((bat --color=always --style=grid $f ||
"         \      highlight -O ansi -l $f ||
"         \      coderay $f ||
"         \      rougify $f) 2> /dev/null | head -500);
"         \ elif [[ ! -e {} ]]; then
"         \   :
"         \ else
"         \   (bat --color=always {} ||
"         \    highlight -O ansi -l {} ||
"         \    coderay {} ||
"         \    rougify {} ||
"         \    cat {} | head -500) 2> /dev/null;
"         \ fi
"         \ "
"         \ --bind "?:toggle-preview"
"         \ --preview-window hidden:wrap
"         \ '
"
"   " floating fzf
"   if has('nvim')
"     let $FZF_DEFAULT_OPTS .= '--border --margin=0,2 --layout=reverse'
"     function! FloatingFZF()
"       let width = float2nr(&columns * 0.9)
"       let height = float2nr(&lines * 0.6)
"       let opts = {
"             \ 'relative': 'editor',
"             \ 'row': (&lines - height) / 2,
"             \ 'col': (&columns - width) / 2,
"             \ 'width': width,
"             \ 'height': height,
"             \ 'style': 'minimal'
"             \ }
"
"       let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
"       call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
"     endfunction
"
"     let g:fzf_layout = { 'window': 'call FloatingFZF()' }
"   endif
""-------------------------------
"" vim-hybrid
"if s:plug.is_installed('vim-hybrid')
"  let g:hybrid_custom_term_colors = 1
"  let g:hybrid_reduced_contrast = 1
"  set background=dark
"  colorscheme hybrid
"  highlight! VertSplit ctermfg=236 ctermbg=236 guibg=#2c2c2c guifg=#2c2c2c
"  " highlight! WarningMsg term=reverse cterm=reverse
"  highlight! SpellBad cterm=underline ctermfg=247 ctermbg=NONE gui=underline guifg=#9e9e9e
"  highlight! SpecialKey cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE
"  " iceberg
"  " highlight! Todo ctermbg=234 ctermfg=150 guibg=#45493e guifg=#b4be82
"  " highlight! Todo ctermbg=NONE ctermfg=150 guibg=NONE guifg=#b4be82
"  " solarized dark
"  " highlight! Todo ctermbg=NONE ctermfg=125 guibg=NONE guifg=#d33682
"  " onedark
"  " highlight! Todo ctermbg=NONE ctermfg=170 guibg=NONE guifg=#C678DD cterm=bold
"  " papercolor
"  " highlight! Todo ctermbg=NONE ctermfg=35 guibg=NONE guifg=#00af5f cterm=bold
"  " gotham
"  " highlight! Todo ctermbg=NONE ctermfg=67 guibg=NONE guifg=#888ca6 cterm=bold
"  highlight! Todo ctermbg=NONE ctermfg=13 guibg=NONE guifg=#888ca6 cterm=bold
"  " Alduin
"  " highlight Todo guifg=#af5f00 guibg=NONE gui=reverse ctermfg=130 ctermbg=NONE cterm=reverse
"  " space-vim-dark
"  " highlight! Todo ctermbg=NONE ctermfg=172 guibg=NONE guifg=#C678DD cterm=bold
"  " molokai
"  " highlight! Todo ctermbg=NONE ctermfg=231 cterm=bold guifg=#FFFFFF guibg=NONE gui=bold
"  highlight! clear CursorLineNr
"  highlight CursorLineNr ctermfg=8 cterm=bold guifg=#8F8F8F
"  highlight GitGutterAdd      ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
"  highlight GitGutterChange   ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
"  highlight GitGutterDelete   ctermfg=9  ctermbg=NONE guifg=#cc6666 guibg=NONE
"  highlight TabLineSel ctermbg=252 ctermfg=235 guibg=#d0d0d0 guifg=#242424
"  highlight PmenuSel ctermbg=236 ctermfg=244 guibg=#353535 guibg=#808080
"  highlight Tabline ctermbg=248 ctermfg=238 guibg=#a8a8a8 guifg=#444444
"  highlight TabLineFill ctermbg=248 ctermfg=238 guibg=#a8a8a8 guifg=#444444
"  highlight clear SpellBad
"  highlight SpellBad cterm=underline gui=undercurl ctermbg=NONE
"        \ ctermfg=NONE guibg=NONE guifg=NONE guisp=NONE
"  highlight QuickScopePrimary guifg=#afff5f gui=underline ctermfg=155 cterm=underline
"  highlight QuickScopeSecondary guifg=#5fffff gui=underline ctermfg=81 cterm=underline
"  highlight! default link CocErrorHighlight WarningMsg
"  highlight! default link CocErrorSign CocErrorHighlight
"  highlight! CocWarningSign  ctermfg=Brown guifg=#ff922b
"  highlight! default link CocInfoSign Title
"  highlight! default link CocHintSign Question
"  highlight clear SignColumn
"  highlight DiffAdd      ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
"  highlight DiffChange   ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
"  highlight DiffDelete   ctermfg=9  ctermbg=NONE guifg=#cc6666 guibg=NONE
"endif

""-------------------------------
"" deoplete-tabnine
"if s:plug.is_installed('deoplete-tabnine')
"  call deoplete#custom#source('tabnine', 'rank', 50)
"  call deoplete#custom#source('tabnine', 'min_pattern_length', 2)
"  call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'tag']})
"  " call deoplete#custom#option('ignore_sources', {'_': ['LanguageClient']})
"endif
"
""-------------------------------
"" deoplete-rust
"if s:plug.is_installed('deoplete-rust')
"  let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
"  let g:deoplete#sources#rust#rust_source_path= substitute(system("rustup which rustc | xargs dirname"), '\n\+$', '', '')
"        \ . '/../lib/rustlib/src/rust/src'
"  let g:deoplete#sources#rust#show_duplicates=1
"endif
"
""-------------------------------
"" LanguageClient-neovim
"if s:plug.is_installed('LanguageClient-neovim')
"  " Automatically start language servers.
"  let g:LanguageClient_autoStart = 1
"  let g:LanguageClient_diagnosticsList = "Location"
"  " let g:LanguageClient_diagnosticsList = "Quickfix"
"  let g:LanguageClient_useFloatingHover = 1
"
"  let g:LanguageClient_serverCommands = {}
"  if executable('rls')
"    " rustup component add rls rust-analysis rust-src
"    let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
"  endif
"
"  if executable('javascript-typescript-stdio')
"    " yarn global add javascript-typescript-langserver   -or-
"    " npm i -g javascript-typescript-langserver
"    let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
"    let g:LanguageClient_serverCommands.javascript.jsx = ['tcp://127.0.0.1:2089']
"    let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
"  endif
"
"  if executable('html-languageserver')
"    " npm i -g vscode-html-languageserver-bin
"    let g:LanguageClient_serverCommands.html = ['html-languageserver', '--stdio']
"  endif
"
"  if executable('css-languageserver')
"    " yarn global add vscode-css-languageserver-bin   -or-
"    " npm i -g vscode-css-languageserver-bin
"    let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
"    let g:LanguageClient_serverCommands.less = ['css-languageserver', '--stdio']
"  endif
"
"  if executable('cquery')
"    " yay -S cquery
"    let g:LanguageClient_serverCommands.cpp = ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}']
"    let g:LanguageClient_serverCommands.c = ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}']
"  endif
"
"  if executable('pyls')
"    " pip install python-language-server
"    let g:LanguageClient_serverCommands.python = ['pyls']
"  endif
"
"  if executable('go-langserver')
"    " go get -u github.com/sourcegraph/go-langserver
"    let g:LanguageClient_serverCommands.go = ['go-langserver']
"  endif
"
"  let s:lsp_filetypes = join(keys(g:LanguageClient_serverCommands), ",")
"  if s:lsp_filetypes != ""
"    function! SetLSPShortcuts() abort
"      nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
"      nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
"      nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
"      nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
"      nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
"      nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
"      nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
"      nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
"      nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
"      nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
"    endfunction()
"
"    augroup vimrc_lsp
"      autocmd!
"      execute 'autocmd FileType ' . s:lsp_filetypes . ' call SetLSPShortcuts()'
"    augroup END
"  endif
"endif
"
""-------------------------------
"" nvim-completion-manager
"if s:plug.is_installed('nvim-completion-manager')
"  " imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
"  " imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
"  " inoremap <c-c> <ESC>
"  " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"  " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"endif
"
""-------------------------------
"" echodoc.vim
"if s:plug.is_installed('echodoc.vim')
"  set noshowmode
"  let g:echodoc_enable_at_startup = 1
"  if has('nvim')
"    let g:echodoc#type = 'virtual'
"  endif
"  set signcolumn=yes
"endif
"
""-------------------------------
"" deoplete-clang
"if s:plug.is_installed('deoplete-clang')
"  let g:deoplete#sources#clang#libclang_path =
"        \ substitute(system("ldconfig -p | \grep libclang.so | awk '{print $4}' | head -n 1"),
"        \ '\n\+$', '', '')
"  if isdirectory('/usr/lib64/clang')
"    let g:deoplete#sources#clang#clang_header = '/usr/lib64/clang/'
"  else
"    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
"  endif
"endif
"
""-------------------------------
"" deoplete-go
"if s:plug.is_installed('deoplete-go')
"  let g:deoplete#sources#go#gocode_binary = $GOPATH . '/bin/gocode'
"endif
"
""-------------------------------
"" denite.nvim
"if s:plug.is_installed('denite.nvim')
"  if executable('ag')
"    call denite#custom#var('file_rec', 'command',
"          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
"
"    " call denite#custom#var('grep', 'command', ['ag'])
"    " call denite#custom#var('grep', 'recursive_opts', [])
"    " call denite#custom#var('grep', 'final_opts', [])
"    " call denite#custom#var('grep', 'separator', [])
"    " call denite#custom#var('grep', 'default_opts',
"    "       \ ['--nocolor', '--nogroup'])
"  endif
"
"  nnoremap    [denite]   <Nop>
"  nmap    <Leader>u [denite]
"  nnoremap <silent> [denite]f :<C-u>Denite file_rec<CR>
"  nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
"  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
"  nnoremap <silent> [denite]u :<C-u>Denite file_mru<CR>
"  nnoremap <silent> [denite]y :<C-u>Denite neoyank<CR>
"  nmap <F8> :<C-u>DeniteCursorWord<Space>grep<CR>
"  nmap <S-F8> :<C-u>DeniteProjectDir<Space>grep<CR>
"endif
"
""-------------------------------
"" deoplete.nvim
"if s:plug.is_installed('deoplete.nvim')
"  " Use deoplete.
"  let g:deoplete#enable_at_startup = 1
"  " Use smartcase.
"  let g:deoplete#enable_smart_case = 1
"  " <C-h>, <BS>: close popup and delete backword char.
"  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr><C-Space>  pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  " too slow neosnippet#expandable_or_jumpable()
"  " inoremap <expr><Tab> pumvisible() ? "\<C-n>" :
"  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<Tab>"
"  " inoremap <expr><C-Space>  pumvisible() ? "\<C-n>" :
"  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<Tab>"
"  " inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" :
"  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<S-Tab>"
"  inoremap <expr><C-y>  deoplete#close_popup()
"  inoremap <expr><C-e>  deoplete#cancel_popup()
"  " <CR>: close popup and save indent.
"  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"  " too slow and https://github.com/Shougo/neosnippet.vim/issues/436#issuecomment-403327057
"  " imap <expr><CR> pumvisible() ? deoplete#close_popup() :
"  "       \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
"  function! s:my_cr_function() abort
"    return pumvisible() ? deoplete#close_popup() : "\<CR>"
"  endfunction
"  command! DeopleteDisable call deoplete#disable()
"  command! DeopleteEnable call deoplete#enable()
"  call deoplete#custom#option('auto_complete_delay', 20)
"  call deoplete#custom#option('auto_refresh_delay', 10)
"endif
"
""-------------------------------
"" completor.vim
"if s:plug.is_installed('completor.vim')
"  let g:completor_gocode_binary = $GOPATH . '/bin/gocode'
"  let g:completor_racer_binary = $HOME . '/.cargo/bin/racer'
"  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
"endif

""-------------------------------
"" vim-racer
"if s:plug.is_installed('vim-racer')
"  set hidden
"  let g:racer_cmd = $HOME . '/.cargo/bin/racer'
"  let g:racer_experimental_completer = 1
"endif

""-------------------------------
"" vim-clang
"if s:plug.is_installed('vim-clang')
"  let g:clang_c_options = '-std=c11'
"  let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"  " disable auto completion for vim-clang
"  let g:clang_auto = 0
"  " default 'longest' can not work with neocomplete
"  let g:clang_c_completeopt = 'menuone,preview'
"  let g:clang_cpp_completeopt = 'menuone,preview'
"  if (v:version == 704 && has('patch775')) || v:version >= 705
"    let g:clang_c_completeopt .= ',noselect'
"    let g:clang_cpp_completeopt .= ',noselect'
"  endif
"  let g:clang_diagsopt = ''
"  " use neocomplete
"  " input patterns
"  if s:plug.is_installed('neocomplete.vim')
"    if !exists('g:neocomplete#force_omni_input_patterns')
"      let g:neocomplete#force_omni_input_patterns = {}
"    endif
"    " for c and c++
"    let g:neocomplete#force_omni_input_patterns.c =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"    let g:neocomplete#force_omni_input_patterns.cpp =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"  endif
"  let g:clang_enable_format_command = 0
"  set nosplitbelow
"endif
"
""-------------------------------
"" vim-snowdrop
"if s:plug.is_installed('vim-snowdrop')
"  let s:libclang_file =
"        \ substitute(system("ldconfig -p | grep libclang | awk '{print $4}'"),
"        \ '\n\+$', '', '')
"  let g:snowdrop#libclang_directory =
"        \ substitute(system('dirname ' . s:libclang_file), '\n\+$', '', '')
"  let g:snowdrop#libclang_file =
"        \ substitute(system('basename ' . s:libclang_file), '\n\+$', '', '')
"  let g:snowdrop#command_options = {
"        \   'cpp' : '-std=c++11',
"        \}
"endif
"
""-------------------------------
"" gtags.vim
"if s:plug.is_installed('gtags.vim')
"  nmap <Leader>] :GtagsCursor<CR>
"  nmap <SubLeader>] :Gtags -r <C-r><C-w><CR>
"endif
"
""-------------------------------
"" neomake
"if s:plug.is_installed('neomake')
"  " Auto check
"  augroup vimrc_neomake
"    autocmd!
"    "autocmd! BufWritePost * Neomake
"  augroup END
"  let g:neomake_error_sign = {'text': 'x', 'texthl': 'NeomakeErrorSign'}
"  let g:neomake_warning_sign = {
"        \   'text': '!',
"        \   'texthl': 'NeomakeWarningSign',
"        \ }
"  let g:neomake_message_sign = {
"        \   'text': '>',
"        \   'texthl': 'NeomakeMessageSign',
"        \ }
"  let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
"endif

""-------------------------------
"" ctrlp.vim
"if s:plug.is_installed('ctrlp.vim')
"  nnoremap [ctrlp] <Nop>
"  nmap <SubLeader>p [ctrlp]
"  nnoremap [ctrlp]a :<C-u>CtrlP<Space>
"  nnoremap [ctrlp]c :<C-u>CtrlPCurWD<CR>
"  nnoremap [ctrlp]b :<C-u>CtrlPBuffer<CR>
"  nnoremap [ctrlp]d :<C-u>CtrlPDir<CR>
"  nnoremap [ctrlp]f :<C-u>CtrlP<CR>
"  nnoremap [ctrlp]l :<C-u>CtrlPLine<CR>
"  nnoremap [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
"  nnoremap [ctrlp]q :<C-u>CtrlPQuickfix<CR>
"  nnoremap [ctrlp]s :<C-u>CtrlPMixed<CR>
"  nnoremap [ctrlp]t :<C-u>CtrlPTag<CR>
"  let g:ctrlp_clear_cache_on_exit = 0
"  let g:ctrlp_mruf_max            = 500
"  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
"  let g:ctrlp_map          = '<Leader>p'
"  let g:ctrlp_cmd          = 'CtrlPLastMode'
"  let g:ctrlp_extensions = ['yankring', 'cmdline', 'funky',
"        \ 'tag', 'buffertag', 'undo', 'changes', 'mixed']
"  " disable 'modified', 'menu', 'quickfix', 'bookmarkdir', 'dir',
"  "         'rtscript', 'line',
"endif
"
""-------------------------------
"" jedi-vim
"if s:plug.is_installed('jedi-vim')
"  let g:jedi#auto_initialization = 1
"  let g:jedi#auto_vim_configuration = 1
"
"  nnoremap [jedi] <Nop>
"  xnoremap [jedi] <Nop>
"  nmap <SubLeader>j [jedi]
"  xmap <SubLeader>j [jedi]
"
"  let g:jedi#completions_command = '<C-N>'
"  let g:jedi#goto_assignments_command = '[jedi]g'
"  let g:jedi#goto_definitions_command = '[jedi]d'
"  let g:jedi#documentation_command = '[jedi]K'
"  let g:jedi#rename_command = '[jedi]r'
"  let g:jedi#usages_command = '[jedi]n'
"  let g:jedi#popup_select_first = 0
"  let g:jedi#popup_on_dot = 0
"
"  augroup vimrc_jedi
"    autocmd!
"    autocmd FileType python setlocal completeopt-=preview
"    if (v:version == 704 && has('patch775')) || v:version >= 705
"      autocmd FileType python setlocal completeopt+=noselect
"    endif
"  augroup END
"
"  " for w/ neocomplete
"  if s:plug.is_installed('neocomplete.vim')
"    augroup vimrc_jedi2
"      autocmd!
"      autocmd FileType python setlocal omnifunc=jedi#completions
"    augroup END
"    let g:jedi#completions_enabled = 0
"    let g:jedi#auto_vim_configuration = 0
"    if !exists('g:neocomplete#force_omni_input_patterns')
"      let g:neocomplete#force_omni_input_patterns = {}
"    endif
"    let g:neocomplete#force_omni_input_patterns.python =
"          \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"  endif
"endif

""-------------------------------
"" neosnippet
"if s:plug.is_installed('neosnippet')
"  let g:neosnippet#enable_snipmate_compatibility = 1
"  let g:neosnippet#enable_completed_snippet = 1
"  " let g:neosnippet#enable_complete_done = 1
"  let g:neosnippet#expand_word_boundary = 1
"  " Plugin key-mappings.
"  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
"  smap <C-s>     <Plug>(neosnippet_expand_or_jump)
"  xmap <C-s>     <Plug>(neosnippet_expand_target)
"  " SuperTab like snippets behavior.
"  "imap <expr><Tab>
"  " \ pumvisible() ? "\<C-n>" :
"  " \ neosnippet#expandable_or_jumpable() ?
"  " \    "\<Tab>" : "\<Plug>(neosnippet_expand_or_jump)"
"  smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
"        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
"  let g:neosnippet#snippets_directory=[
"        \ '~/.vim/snippets',
"        \ g:plug_home . '/neosnippet-snippets/neosnippets',
"        \ g:plug_home . '/vim-snippets/snippets'
"        \ ]
"endif

""-------------------------------
"" neocomplete
"if s:plug.is_installed('neocomplete.vim')
"  " 新しく追加した neocomplete の設定
"  ""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"  " Disable AutoComplPop.
"  let g:acp_enableAtStartup = 0
"  " Use neocomplete.
"  let g:neocomplete#enable_at_startup = 1
"  " Use smartcase.
"  let g:neocomplete#enable_smart_case = 1
"  " Set minimum syntax keyword length.
"  let g:neocomplete#sources#syntax#min_keyword_length = 3
"  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"  " Define dictionary.
"  let g:neocomplete#sources#dictionary#dictionaries = {
"        \ 'default' : '',
"        \ 'vimshell' : $HOME.'/.vimshell_hist',
"        \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"  " Define keyword.
"  if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"  endif
"  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"  " Plugin key-mappings.
"  inoremap <expr><C-g>     neocomplete#undo_completion()
"  inoremap <expr><C-l>     neocomplete#complete_common_string()
"  " Recommended key-mappings.
"  " <CR>: close popup and save indent.
"  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"  function! s:my_cr_function() abort
"    "return neocomplete#close_popup() . "\<CR>"
"    " For no inserting <CR> key.
"    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"  endfunction
"  " <Tab>: completion.
"  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  " <C-h>, <BS>: close popup and delete backword char.
"  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><C-y>  neocomplete#close_popup()
"  inoremap <expr><C-e>  neocomplete#cancel_popup()
"  " Close popup by <Space>.
"  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
"  " For cursor moving in insert mode(Not recommended)
"  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"  " Or set this.
"  "let g:neocomplete#enable_cursor_hold_i = 1
"  " Or set this.
"  "let g:neocomplete#enable_insert_char_pre = 1
"
"  " AutoComplPop like behavior.
"  "let g:neocomplete#enable_auto_select = 1
"
"  " Shell like behavior(not recommended).
"  "set completeopt+=longest
"  "let g:neocomplete#enable_auto_select = 1
"  "let g:neocomplete#disable_auto_complete = 1
"  "inoremap <expr><Tab>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"  " Enable omni completion.
"  augroup vimrc_neocomplete
"    autocmd!
"    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"  augroup END
"
"  " Enable heavy omni completion.
"  if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"  endif
"  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"  " For perlomni.vim setting.
"  " https://github.com/c9s/perlomni.vim
"  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"  let g:neocomplete#force_overwrite_completefunc=1
"  "
"endif
"
""-------------------------------
"" neocomplcache
"if s:plug.is_installed('neocomplcache.vim')
"  let g:neocomplcache_max_list = 30
"  let g:neocomplcache_auto_completion_start_length = 2
"  let g:neocomplcache_force_overwrite_completefunc=1
"
"  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"  " Disable AutoComplPop.
"  let g:acp_enableAtStartup = 0
"  " Use neocomplcache.
"  let g:neocomplcache_enable_at_startup = 1
"  " Use smartcase.
"  let g:neocomplcache_enable_smart_case = 1
"  " Set minimum syntax keyword length.
"  let g:neocomplcache_min_syntax_length = 3
"  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"  " Enable heavy features.
"  " Use camel case completion.
"  "let g:neocomplcache_enable_camel_case_completion = 1
"  " Use underbar completion.
"  "let g:neocomplcache_enable_underbar_completion = 1
"
"  " Define dictionary.
"  let g:neocomplcache_dictionary_filetype_lists = {
"        \ 'default' : '',
"        \ 'vimshell' : $HOME.'/.vimshell_hist',
"        \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"  " Define keyword.
"  if !exists('g:neocomplcache_keyword_patterns')
"    let g:neocomplcache_keyword_patterns = {}
"  endif
"  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
"  " Plugin key-mappings.
"  inoremap <expr><C-g>     neocomplcache#undo_completion()
"  inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
"  " Recommended key-mappings.
"  " <CR>: close popup and save indent.
"  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"  function! s:my_cr_function() abort
"    "return neocomplcache#smart_close_popup() . "\<CR>"
"    " For no inserting <CR> key.
"    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"  endfunction
"  " <Tab>: completion.
"  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  " <C-h>, <BS>: close popup and delete backword char.
"  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"  inoremap <expr><C-y>  neocomplcache#close_popup()
"  inoremap <expr><C-e>  neocomplcache#cancel_popup()
"  " Close popup by <Space>.
"  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"
"
"  " For cursor moving in insert mode(Not recommended)
"  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
"  " Or set this.
"  "let g:neocomplcache_enable_cursor_hold_i = 1
"  " Or set this.
"  "let g:neocomplcache_enable_insert_char_pre = 1
"
"  " AutoComplPop like behavior.
"  "let g:neocomplcache_enable_auto_select = 1
"
"  " Shell like behavior(not recommended).
"  "set completeopt+=longest
"  "let g:neocomplcache_enable_auto_select = 1
"  "let g:neocomplcache_disable_auto_complete = 1
"  "inoremap <expr><Tab>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"  " Enable omni completion.
"  augroup vimrc_neocomplcache
"    autocmd!
"    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"  augroup END
"
"  " Enable heavy omni completion.
"  if !exists('g:neocomplcache_force_omni_patterns')
"    let g:neocomplcache_force_omni_patterns = {}
"  endif
"  let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"  " For perlomni.vim setting.
"  " https://github.com/c9s/perlomni.vim
"  let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"endif
"
""-------------------------------
"" unite
"if s:plug.is_installed('unite.vim')
"  let g:unite_enable_start_insert=1
"  let g:unite_source_file_mru_limit = 200
"  " The prefix key.
"  nnoremap    [unite]   <Nop>
"  nmap    <Leader>u [unite]
"  " unite.vim keymap
"  let g:unite_source_history_yank_enable =1
"  nnoremap <silent> [unite]u :<C-u>Unite<Space>file<CR>
"  nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
"  nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
"  nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
"  nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"  nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
"  nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"  nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"  nnoremap <silent> <SubLeader>vr :UniteResume<CR>
"  " unite-build map
"  nnoremap <silent> <SubLeader>vb :Unite build<CR>
"  nnoremap <silent> <SubLeader>vcb :Unite build:!<CR>
"  nnoremap <silent> <SubLeader>vch :UniteBuildClearHighlight<CR>
"  "let g:unite_source_grep_command = 'ag'
"  "let g:unite_source_grep_default_opts = '--nocolor --nogroup'
"  "let g:unite_source_grep_max_candidates = 200
"  let g:unite_source_grep_recursive_opt = '-rI'
"  " unite-grepの便利キーマップ
"  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
"  nmap <F8> :<C-u>UniteWithCursorWord<Space>grep:%<CR>
"  nmap <S-F8> :<C-u>UniteWithCurrentDir<Space>grep<CR>
"  nmap <C-F8> :<C-u>UniteWithBufferDir<Space>grep<CR>
"  nmap <C-S-F8> :<C-u>UniteWithProjectDir<Space>grep<CR>
"  " ファイルを開く時、ウィンドウを分割して開く
"  augroup vimrc_unite
"    autocmd!
"    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
"    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
"    " ファイルを開く時、ウィンドウを縦に分割して開く
"    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
"    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
"    " ESCキーを2回押すと終了する
"    autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
"    autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"  augroup END
"endif

" "-------------------------------
" " vim-marching
" if s:plug.is_installed('vim-marching')
" " clang コマンドの設定
" let g:marching_clang_command = 'clang'
" " オプションを追加する
" " filetype=cpp に対して設定する場合
" let g:marching#clang_command#options = {
" \   'c'   : '-stdlib=libstdc --pedantic-errors',
" \   'cpp' : '-std=c++11 -stdlib=libstdc++ --pedantic-errors'
" \}
" " インクルードディレクトリのパスを設定
" let g:marching_include_paths = filter(copy(split(&path, ',')), "v:val !~? '^$'")
" " neocomplete.vim と併用して使用する場合
" let g:marching_enable_neocomplete = 1
" if !exists('g:neocomplete#force_omni_input_patterns')
" let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.cpp =
" \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" " 処理のタイミングを制御する
" " 短いほうがより早く補完ウィンドウが表示される
" " ただし、marching.vim 以外の処理にも影響するので注意する
" set updatetime=100
" " オムニ補完時に補完ワードを挿入したくない場合
" imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
" " キャッシュを削除してからオムに補完を行う
" imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)
" " 非同期ではなくて、同期処理でコード補完を行う場合
" " この設定の場合は vimproc.vim に依存しない
" " let g:marching_backend = 'sync_clang_command'
" endif

"-------------------------------
"" vim-tags
"if s:plug.is_installed('vim-tags')
"let g:vim_tags_auto_generate = 1
"let g:vim_tags_use_vim_dispatch = 0
"endif

"-------------------------------
"" syntastic
"if s:plug.is_installed('syntastic')
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_enable_signs = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_save = 1
"endif

"-------------------------------
"" SrcExpl
"nmap <F8> :<C-u>SrcExplToggle<CR>
"let g:SrcExpl_winHeight = 8
"let g:SrcExpl_refreshTime = 100
"let g:SrcExpl_gobackKey = "<SPACE>"
"let g:SrcExpl_pluginList = [
"        \ "__Tag_List__",
"        \ "NERD_tree_1",
"        \ "[quickrun output]",
"        \ "[unite] - default",
"        \ "vimfiler:default",
"        \ "ControlP",
"        \ "Source_Explorer"
"        \ ]
"let g:SrcExpl_searchLocalDef = 0
"let g:SrcExpl_isUpdateTags = 0
"let g:SrcExpl_updateTagsKey = "<F12>"
"let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
"
"-------------------------------
"" Trinity
"nmap <F8>   :<C-u>TrinityToggleAll<CR>
"nmap <F9>   :<C-u>TrinityToggleSourceExplorer<CR>
"nmap <F10>  :<C-u>TrinityToggleTagList<CR>
"nmap <F11>  :<C-u>TrinityToggleNERDTree<CR>
"nmap <C-j> <C-]>

"-------------------------------
"" Taglist
"if s:plug.is_installed('Taglist')
"  echo "a"
"let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
"let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる
"let Tlist_WinWidth = 50
"endif

"-------------------------------
"" im_control.vim
"if s:plug.is_installed('im_control.vim')
"" 「日本語入力固定モード」切替キー
"inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
"" PythonによるIBus制御指定
"let IM_CtrlIBusPython = 1
"
"" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
"set timeout timeoutlen=3000 ttimeoutlen=10
"endif

" }}}

