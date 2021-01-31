
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
  nnoremap g<C-p> <Cmd>CtrlPYankRound<CR>
  "nnoremap <SID>(ctrlp) <Cmd>CtrlP<CR>
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
  nmap <cscope>s <Cmd>cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>g <Cmd>cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>c <Cmd>cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>t <Cmd>cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>e <Cmd>cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <cscope>f <Cmd>cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <cscope>i <Cmd>cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <cscope>d <Cmd>cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"-------------------------------
" vim-quickhl
if s:plug.is_installed('vim-quickhl')
  nmap <Leader>m <Plug>(quickhl-manual-this-whole-word)
  xmap <Leader>m <Plug>(quickhl-manual-this-whole-word)
  nmap <Leader>M <Plug>(quickhl-manual-reset)
  xmap <Leader>M <Plug>(quickhl-manual-reset)
  nnoremap <F5> :<C-u>nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>:QuickhlManualReset<CR><C-l>

  if ! vimrc#is_supported_truecolor()
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
  map  <easymotion>w <Plug>(easymotion-bd-w)

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
" vim-asterisk
if s:plug.is_installed('vim-asterisk')
  if s:plug.is_installed('vim-anzu')
    map g*  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
    map g#  <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
    map * <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  else
    map g*  <Plug>(asterisk-z*)
    map g#  <Plug>(asterisk-z#)
    map * <Plug>(asterisk-gz*)
  endif
  " map # <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)
  let g:asterisk#keeppos = 1
endif

"-------------------------------
" autopreview
if s:plug.is_installed('autopreview')
  let g:AutoPreview_enabled =0
  set updatetime=100
  set previewheight =8
  nnoremap <SubLeader>t <Cmd>AutoPreviewToggle<CR>
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
  nmap <C-a> <Plug>(milfeulle-prev)
  nmap <C-g> <Plug>(milfeulle-next)
  nmap [j <Plug>(milfeulle-prev)
  nmap ]j <Plug>(milfeulle-next)
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
" vim-togglelist
if s:plug.is_installed('vim-togglelist')
  nmap <script> <LocalLeader>l <Cmd>call ToggleLocationList()<CR>
  nmap <script> <LocalLeader>q <Cmd>call ToggleQuickfixList()<CR>
  let g:toggle_list_copen_command='botright copen'
endif

"-------------------------------
" ListToggle
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
" vim-diminactive
if s:plug.is_installed('vim-diminactive')
  let g:diminactive = 0
  let g:diminactive_enable_focus = 1
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
" clever-f.vim
if s:plug.is_installed('clever-f.vim')
  let g:clever_f_ignore_case = 0
  let g:clever_f_across_no_line = 1
  let g:clever_f_fix_key_direction = 1
  "map ; <Plug>(clever-f-repeat-forward)
  "map , <Plug>(clever-f-repeat-back)
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
    autocmd FileType rust nnoremap <buffer> <C-S-F1> <Cmd>RustDocsCurrentWord<CR>
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
endif

"-------------------------------
" vim-polyglot
if s:plug.is_installed('vim-polyglot')
  let g:csv_no_conceal = 0
  autocmd! filetypedetect * *.tmux
endif

"-------------------------------
" lexima.vim
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
  nnoremap <make>n <Cmd>TestNearest<CR>
  nnoremap <make>f <Cmd>TestFile<CR>
  nnoremap <make>s <Cmd>TestSuite<CR>
  nnoremap <make>l <Cmd>TestLast<CR>
  nnoremap <make>v <Cmd>TestVisit<CR>
  let g:test#rust#cargotest#options = '-- --nocapture'
  let g:test#rust#cargotest#executable = 'RUST_BACKTRACE=1 cargo test'

  command! TestCurrent wa <Bar> execute 'TestNearest ' . get(b:, 'vista_nearest_method_or_function', '')
  nnoremap <make>c <Cmd>TestCurrent<CR>
endif

"-------------------------------
" asynctasks.vim
if s:plug.is_installed('asynctasks.vim')
  nnoremap <make>b <Cmd>AsyncTask project-build<CR>
  let g:asynctasks_extra_config = [
        \ '~/.vim/tasks/my_tasks.ini',
        \ ]
  let g:asynctasks_template = {}
  let g:asynctasks_template.cargo = [
        \ "[project-init]",
        \ "command=cargo update",
        \ "cwd=<root>",
        \ "",
        \ "[project-build]",
        \ "command=cargo build",
        \ "cwd=<root>",
        \ "errorformat=%. %#--> %f:%l:%c",
        \ "",
        \ "[project-run]",
        \ "command=cargo run",
        \ "cwd=<root>",
        \ "output=terminal",
        \ ]
endif

"-------------------------------
" asyncrun.vim
if s:plug.is_installed('asyncrun.vim')
  let g:asyncrun_open = float2nr(&lines * 0.25)
  " https://github.com/skywind3000/asyncrun.vim/blob/58d23e70569994b36208ed2a653f0a2d75c24fbc/doc/asyncrun.txt#L181
  augroup vimrc_asyncrun
    autocmd!
    autocmd User AsyncRunStop copen | $ | wincmd p
  augroup END
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
  let s:cache_file_dir = expand('~/.cache/nvim/files/')
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

  nmap <Leader>v <Cmd>Vista finder<CR>
  nmap gt <Cmd>Vista!!<CR>

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
  nnoremap <xtabline>   <Nop>
  nmap    X <xtabline>
  let g:xtabline_settings.map_prefix = '<xtabline>'
  " let g:xtabline_settings.enable_mappings = 1
  let g:xtabline_settings.bufline_format = ' N I< l +'
  let g:xtabline_settings.recent_buffers = 99
  let g:xtabline_settings.tab_number_in_buffers_mode = 0
  let g:xtabline_settings.sessions_path = $HOME . '/.local/share/nvim/session'
  let g:xtabline_settings.bookmarks_file = $HOME . '/.local/share/nvim/.XTablineBookmarks'
  let g:xtabline_settings.sessions_data = $HOME . '/.local/share/nvim/.XTablineSessions'
  nmap <F2> <Cmd>if vimrc#is_normal_buffer() <Bar> execute v:count1 "XTabPrevBuffer" <Bar> endif <CR>
  nmap <F3> <Cmd>if vimrc#is_normal_buffer() <Bar> execute v:count1 "XTabNextBuffer" <Bar> endif <CR>
  nmap H <Cmd>if vimrc#is_normal_buffer() <Bar> execute v:count1 "XTabPrevBuffer" <Bar> endif <CR>
  nmap L <Cmd>if vimrc#is_normal_buffer() <Bar> execute v:count1 "XTabNextBuffer" <Bar> endif <CR>
  nmap <F4> <Cmd>XTabCloseBuffer<CR><Cmd>XTabPurge<CR>
  nmap <C-x> <Cmd>XTabCloseBuffer<CR><Cmd>XTabPurge<CR>
  nmap <S-F4> <Cmd>XTabCloseBuffer<CR><Cmd>XTabPurge<CR>
  nmap <C-F4> <Cmd>XTabCloseBuffer<CR><Cmd>XTabPurge<CR>
  nmap <C-S-F2> <Cmd>XTabMoveBufferPrev<CR>
  nmap <C-S-F3> <Cmd>XTabMoveBufferNext<CR>
  nmap <S-PageUp>   <Cmd>XTabMoveBufferPrev<CR>
  nmap <S-PageDown> <Cmd>XTabMoveBufferNext<CR>
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
" barbar.nvim
if s:plug.is_installed('barbar.nvim')
  " Magic buffer-picking mode
  nnoremap <Leader>b <Cmd>BufferPick<CR>
  nnoremap <F4> <Cmd>BufferClose<CR>
  nnoremap <C-X> <Cmd>BufferClose<CR>
  nnoremap <S-F4> <Cmd>BufferClose<CR>
  nnoremap <C-F4> <Cmd>BufferClose<CR>
  " Move to previous/next
  nnoremap <silent>    H :BufferPrevious<CR>
  nnoremap <silent>    L :BufferNext<CR>
  " Re-order to previous/next
  nnoremap <silent>    <C-S-F2> :BufferMovePrevious<CR>
  nnoremap <silent>    <C-S-F3> :BufferMoveNext<CR>
  nnoremap <silent>    @ :BufferMovePrevious<CR>
  nnoremap <silent>    # :BufferMoveNext<CR>
  " Goto buffer in position...
  nnoremap <Space>1 <Cmd>BufferGoto 1<CR>
  nnoremap <Space>2 <Cmd>BufferGoto 2<CR>
  nnoremap <Space>3 <Cmd>BufferGoto 3<CR>
  nnoremap <Space>4 <Cmd>BufferGoto 4<CR>
  nnoremap <Space>5 <Cmd>BufferGoto 5<CR>
  nnoremap <Space>6 <Cmd>BufferGoto 6<CR>
  nnoremap <Space>7 <Cmd>BufferGoto 7<CR>
  nnoremap <Space>8 <Cmd>BufferGoto 8<CR>
  nnoremap <Space>9 <Cmd>BufferLast<CR>

  let bufferline = {}

  " Show a shadow over the editor in buffer-pick mode
  let bufferline.shadow = v:true
  " Enable/disable animations
  let bufferline.animation = v:true
  " Enable/disable icons
  let bufferline.icons = 'both'
  " let bufferline.icons = v:true
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
  " Sets the maximum padding width with which to surround each tab
  let bufferline.maximum_padding = 0

  " romgrk/doom-one.vim
  highlight BufferCurrent guifg=#E6E6E6 guibg=#282c34
  highlight BufferCurrentIndex guifg=#73797e guibg=#282c34
  highlight BufferCurrentMod guifg=#ECBE7B guibg=#282c34
  highlight BufferCurrentSign guifg=#51afef guibg=#282c34
  highlight BufferCurrentTarget gui=bold guifg=#ff6c6b guibg=#282c34
  highlight BufferVisible guifg=#E6E6E6 guibg=#282c34
  highlight BufferVisibleIndex guifg=#E6E6E6 guibg=#282c34
  highlight BufferVisibleMod guifg=#ECBE7B guibg=#282c34
  highlight BufferVisibleSign guifg=#3f444a guibg=#282c34
  highlight BufferVisibleTarget gui=bold guifg=#ff6c6b guibg=#282c34
  highlight BufferInactive guifg=#73797e guibg=#1c1f24
  highlight BufferInactiveIndex guifg=#73797e guibg=#1c1f24
  highlight BufferInactiveMod guifg=#ECBE7B guibg=#1c1f24
  highlight BufferInactiveSign guifg=#3f444a guibg=#1c1f24
  highlight BufferInactiveTarget gui=bold guifg=#ff6c6b guibg=#1c1f24
  highlight BufferTabpages gui=bold guifg=#51afef guibg=#3E4556
  highlight BufferTabpageFill gui=bold guifg=#3f444a guibg=#1c1f24

  augroup vimrc_barbar
    autocmd!
    autocmd TermOpen * setlocal nobuflisted
    autocmd FileType qf setlocal nobuflisted
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
  nnoremap <unique> <Leader><Leader>bc <Cmd>Clap bcommits<CR>
  nnoremap <unique> <Leader><Leader>l <Cmd>Clap blines<CR>
  nnoremap <unique> <Leader><Leader>b <Cmd>Clap buffers<CR>
  " nnoremap <unique> <Leader><Leader> <Cmd>Clap colors<CR>
  nnoremap <unique> <Leader><Leader>h <Cmd>Clap hist<CR>
  nnoremap <unique> <Leader><Leader>c <Cmd>Clap commits<CR>
  nnoremap <unique> <Leader><Leader>f <Cmd>Clap files<CR>
  " nnoremap <unique> <Leader><Leader> <Cmd>Clap filetypes<CR>
  nnoremap <unique> <Leader><Leader>p <Cmd>Clap git_files<CR>
  nnoremap <unique> <Leader><Leader>g <Cmd>Clap grep<CR>
  nnoremap <unique> <Leader><Leader>j <Cmd>Clap jumps<CR>
  nnoremap <unique> <Leader><Leader>m <Cmd>Clap marks<CR>
  nnoremap <unique> <Leader><Leader>t <Cmd>Clap tags<CR>
  " nnoremap <unique> <Leader><Leader> <Cmd>Clap windows<CR>
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
  nnoremap <Leader><CR>      <Cmd>WhichKey '<lt>Space>'<CR>
  nnoremap <SubLeader><CR> <Cmd>WhichKey  '<SubLeader>'<CR>
  nnoremap <LocalLeader><CR> <Cmd>WhichKey  '<LocalLeader>'<CR>
  nnoremap <make><CR> <Cmd>WhichKey  '<make>'<CR>
  nnoremap <debugger><CR> <Cmd>WhichKey  '<debugger>'<CR>
  nnoremap <fuzzy-finder><CR> <Cmd>WhichKey  '<fuzzy-finder>'<CR>
  nnoremap <fuzzy-finder-resume><CR> <Cmd>WhichKey  '<fuzzy-finder-resume>'<CR>
  nnoremap <coc><CR> <Cmd>WhichKey  '<coc>'<CR>
  nnoremap <easymotion><CR> <Cmd>WhichKey  '<easymotion>'<CR>
  nnoremap <xtabline><CR> <Cmd>WhichKey  '<xtabline>'<CR>
  nnoremap <terminal><CR> <Cmd>WhichKey  "'"<CR>
  nnoremap g<CR> <Cmd>WhichKey  'g'<CR>
  nnoremap [<CR> <Cmd>WhichKey  '['<CR>
  nnoremap ]<CR> <Cmd>WhichKey  ']'<CR>
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
  nnoremap <Leader>] :AnyJump<CR>
  " Visual mode: jump to selected text in visual mode
  xnoremap <Leader>] :AnyJumpVisual<CR>
  " Normal mode: open previous opened file (after jump)
  nnoremap <Leader>[ :AnyJumpBack<CR>
  " Normal mode: open last closed search window again
  nnoremap <Leader>} :AnyJumpLastResults<CR>
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
  " do not use a/d/r(sandwich)
  nnoremap <debugger>   <Nop>
  nmap    s <debugger>
  command! SpectorLaunch call vimspector#Launch()
  command! SpectorStop VimspectorReset
  nmap <debugger>c  <Plug>VimspectorContinue
  nmap <debugger>q  <Plug>VimspectorStop
  nmap <debugger>t  <Plug>VimspectorRestart
  nmap <debugger>,  <Plug>VimspectorPause
  nmap <debugger>b  <Plug>VimspectorToggleBreakpoint
  nmap <debugger>f  <Plug>VimspectorAddFunctionBreakpoint
  nmap <debugger>n  <Plug>VimspectorStepOver
  nmap <debugger>i  <Plug>VimspectorStepInto
  nmap <debugger>o  <Plug>VimspectorStepOut
endif

"-------------------------------
" nvim-dap
if s:plug.is_installed('nvim-dap')
  execute "lua require'pluginconfig/nvim-dap'"
  " do not use a/d/r(sandwich)
  nnoremap <debugger>   <Nop>
  nmap    s <debugger>
  nmap <debugger>l <Cmd>lua require'dap'.run()<CR>
  nmap <debugger>c <Cmd>lua require'dap'.continue()<CR>
  nmap <debugger>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
  nmap <debugger>n <Cmd>lua require'dap'.step_over()<CR>
  nmap <debugger>i <Cmd>lua require'dap'.step_into()<CR>

  if s:plug.is_installed('telescope-dap.nvim')
    nmap <debugger>L <Cmd>lua require'telescope'.extensions.dap.commands{}<CR>
    nmap <debugger>C <Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>
    nmap <debugger>B <Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>
    nmap <debugger>V <Cmd>lua require'telescope'.extensions.dap.variables{}<CR>
  endif
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
" nvim-treesitter
if s:plug.is_installed('nvim-treesitter')
  nmap <SubLeader>e <Cmd>e!<CR>
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
  nnoremap <F10> <Cmd>call quickui#menu#open()<cr>
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
" vim-niceblock
if s:plug.is_installed('vim-niceblock')
  let g:niceblock_no_default_key_mappings = 0
  xmap I  <Plug>(niceblock-I)
  xmap gI  <Plug>(niceblock-gI)
endif

"-------------------------------
" mkdx
if s:plug.is_installed('mkdx')
  let g:mkdx#settings     = {
        \ 'map': { 'map': { 'enable': 1 }, 'prefix': '<localleader>' },
        \ 'highlight': { 'enable': 1 },
        \ 'enter': { 'shift': 0 },
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
  nnoremap <Leader>- <Cmd>call you_are_here#Toggle()<CR>
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
  let g:bakaup_backup_dir = expand('~/.cache/nvim/aho-bakaup')
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
" indent-guides.nvim
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

"-------------------------------
" contextprint.nvim
if s:plug.is_installed('contextprint.nvim')
  lua <<EOF
    require('contextprint').setup({
        separator_char = ":",
        include_class = true,
        include_function = true,
        include_method = true,
        include_if = false,
        include_for = false
    })
EOF
endif

"-------------------------------
" vim-workspace
if s:plug.is_installed('vim-workspace')
  let g:workspace_session_directory = $HOME . '/.local/share/nvim/sessions/'
  let g:workspace_undodir= $HOME . '/.local/share/nvim/undodir'
  let g:workspace_autosave_always = 1
endif

"-------------------------------
" helpeek.vim
if s:plug.is_installed('helpeek.vim')
  cnoremap <C-q> <Cmd>Helpeek<CR>
endif

"-------------------------------
" Colorizer
if s:plug.is_installed('Colorizer')
  let g:colorizer_auto_color = 0
endif

"-------------------------------
" vim-translator
if s:plug.is_installed('vim-translator')
  let g:translator_target_lang = 'ja'
endif

"-------------------------------
" nvim-scrollview
if s:plug.is_installed('nvim-scrollview')
  highlight ScrollView ctermbg=159 guibg=LightCyan
endif

"-------------------------------
" nvim-hlslens
if s:plug.is_installed('nvim-hlslens')
  execute "lua require('hlslens').setup()"
  noremap n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
        \<Cmd>lua require('hlslens').start()<CR>
  noremap N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
        \<Cmd>lua require('hlslens').start()<CR>

  if s:plug.is_installed('vim-asterisk')
    map *  <Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>
    " map #  <Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>
    map g* <Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>
    map g# <Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>
  else
    noremap * *<Cmd>lua require('hlslens').start()<CR>
    " noremap # #<Cmd>lua require('hlslens').start()<CR>
    noremap g* g*<Cmd>lua require('hlslens').start()<CR>
  endif
endif

"-------------------------------
" replacer.nvim
if s:plug.is_installed('replacer.nvim')
  command! QfReplacer lua require("replacer").run()<cr>
endif

"-------------------------------
" aerojump.nvim
if s:plug.is_installed('aerojump.nvim')
  nmap <SubLeader>as <Plug>(AerojumpSpace)
  nmap <SubLeader>ab <Plug>(AerojumpBolt)
  nmap <SubLeader>aa <Plug>(AerojumpFromCursorBolt)
  nmap <SubLeader>ad <Plug>(AerojumpDefault)
endif

"-------------------------------
" vim-autosave
if s:plug.is_installed('vim-autosave')
  let g:autosave_backup = expand('~/.local/share/nvim/backup')
endif

"-------------------------------
" vim-floaterm
if s:plug.is_installed('vim-floaterm')
  let g:floaterm_height = 0.8
  let g:floaterm_width = 0.8

  nnoremap <terminal>   <Nop>
  nmap    <C-z> <terminal>
  nnoremap <terminal>  <Cmd>FloatermToggle<CR>
  nnoremap <terminal><C-z> <Cmd>FloatermToggle<CR>
  nnoremap <terminal>a <Cmd>FloatermNew<CR>
  nnoremap <terminal>p <Cmd>FloatermPrev<CR>
  nnoremap <terminal>n <Cmd>FloatermNext<CR>
  nnoremap <terminal>l <Cmd>FloatermLast<CR>
	nnoremap <silent>   <F7>    :FloatermNew<CR>
	tnoremap <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
	nnoremap <silent>   <F8>    :FloatermPrev<CR>
	tnoremap <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
	nnoremap <silent>   <F9>    :FloatermNext<CR>
	tnoremap <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
  command! Wqa execute ':FloatermKill!' | wqa
  cnoreabbrev wqa Wqa
  augroup vimrc_floaterm
    autocmd!
    autocmd User FloatermOpen nnoremap <buffer> <silent> <Esc> <Cmd>FloatermToggle<CR>
    autocmd User FloatermOpen tnoremap <buffer> <silent> <C-z> <C-\><C-n>:FloatermToggle<CR>
    autocmd User FloatermOpen tnoremap <buffer> <silent> <F1> <C-\><C-n>:FloatermNew<CR>
    autocmd User FloatermOpen tnoremap <buffer> <silent> <F2> <C-\><C-n>:FloatermPrev<CR>
    autocmd User FloatermOpen tnoremap <buffer> <silent> <F3> <C-\><C-n>:FloatermNext<CR>
    autocmd QuitPre * FloatermKill!
  augroup END
endif


" }}}


" ---


"===============================
" textobj/operator           {{{
"===============================

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
  map X <Plug>(operator-replace)
endif

"-------------------------------
" vim-operator-flashy
if s:plug.is_installed('vim-operator-flashy')
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
endif

"-------------------------------
" targets.vim
if s:plug.is_installed('targets.vim')
endif

" }}}


"===============================
" telescope                  {{{
"===============================

"-------------------------------
" telescope.nvim
if s:plug.is_installed('telescope.nvim')
  execute "lua require'pluginconfig/telescope'"
  nnoremap <fuzzy-finder>   <Nop>
  vnoremap <fuzzy-finder>   <Nop>
  nmap    z <fuzzy-finder>
  vmap    z <fuzzy-finder>
  nnoremap <Leader>p <Cmd>Telescope my_mru<CR>
  nnoremap <fuzzy-finder>p  <Cmd>Telescope find_files<CR>
  nnoremap <Leader>; <Cmd>Telescope git_files<CR>
  nnoremap <fuzzy-finder>;  <Cmd>Telescope git_files<CR>
  nnoremap <Leader>. <Cmd>Telescope find_files<CR>
  nnoremap <fuzzy-finder>.  <Cmd>Telescope my_mru<CR>
  nnoremap <Leader>, <Cmd>Telescope grep_prompt<CR>
  nnoremap <fuzzy-finder>, :<C-u>Telescope grep_prompt<CR>
  vnoremap <fuzzy-finder>, y:Telescope my_grep search=<C-r>=escape(@", '\\.*$^[] ')<CR>
  nnoremap <Leader>/ :<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>
  nnoremap <fuzzy-finder>/ :<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>
  nnoremap <fuzzy-finder>g <Cmd>Telescope live_grep<CR>
  nnoremap <fuzzy-finder>b <Cmd>Telescope buffers<CR>
  nnoremap <fuzzy-finder>h <Cmd>Telescope help_tags<CR>
  nnoremap <fuzzy-finder>c <Cmd>Telescope commands<CR>
  nnoremap <fuzzy-finder>t <Cmd>Telescope treesitter<CR>
  nnoremap <fuzzy-finder>q <Cmd>Telescope quickfix<CR>
  nnoremap <fuzzy-finder>l <Cmd>Telescope loclist<CR>
  nnoremap <fuzzy-finder>m <Cmd>Telescope marks<CR>
  nnoremap <fuzzy-finder>r <Cmd>Telescope registers<CR>
  nnoremap <fuzzy-finder>* <Cmd>Telescope grep_string<CR>
endif

"-------------------------------
" telescope-media-files.nvim
if s:plug.is_installed('telescope-media-files.nvim')
  execute "lua require('telescope').load_extension('media_files')"
endif

"-------------------------------
" telescope-project.nvim
if s:plug.is_installed('telescope-project.nvim')
  execute "lua require('telescope').load_extension('project')"
endif

"-------------------------------
" telescope-github.nvim
if s:plug.is_installed('telescope-github.nvim')
  execute "lua require('telescope').load_extension('gh')"
endif

"-------------------------------
" telescope-fzf-writer.nvim
if s:plug.is_installed('telescope-fzf-writer.nvim')
  execute "lua require('telescope').load_extension('fzf_writer')"
endif

"-------------------------------
" telescope-ghq.nvim
if s:plug.is_installed('telescope-ghq.nvim')
  execute "lua require('telescope').load_extension('ghq')"
endif

"-------------------------------
" telescope-memo.nvim
if s:plug.is_installed('telescope-memo.nvim')
  execute "lua require('telescope').load_extension('memo')"
endif

"-------------------------------
" telescope-z.nvim
if s:plug.is_installed('telescope-z.nvim')
  execute "lua require('telescope').load_extension('z')"
endif

"-------------------------------
" telescope-frecency.nvim
if s:plug.is_installed('telescope-frecency.nvim')
  execute "lua require('telescope').load_extension('frecency')"
endif

"-------------------------------
" telescope-dap.nvim
if s:plug.is_installed('telescope-dap.nvim')
  execute "lua require('telescope').load_extension('dap')"
endif

"-------------------------------
" scratch.vim
if s:plug.is_installed('scratch.vim')
  let g:scratch_no_mappings = 1
endif

" }}}


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
        \   'root_dir': 'LightLineRootDir',
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
        \              ['root_dir', 'git_branch', 'git_blame'],
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

  nnoremap ! <Cmd>call LightLineToggle()<CR>
  function! LightLineToggle() abort
    let g:lightline.active = g:lightline.active ==# s:lightline_mode1 ? s:lightline_mode2 : s:lightline_mode1
    call lightline#init()
    call lightline#update()
    " Rerender the tabline because lightline's tabline set is faster than barbar
    if exists("*bufferline#render")
      let &tabline = bufferline#render(v:true)
    endif
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

  function! LightLineRootDir() abort
    if winwidth(0) > 150
      return fnamemodify(getcwd(), ':t')
    endif
    return ''
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
  map <F1> <Cmd>call RefDoc()<CR>

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
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " <C-w>p switch floating window

  " Use K to show documentation in preview window
  nnoremap ? <Cmd>call <SID>show_documentation()<CR>

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
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

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
  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Using CocList
  nnoremap <coc>m  <Cmd>CocList<cr>
  " Show all diagnostics
  nnoremap <coc>d  <Cmd>CocDiagnostics<cr>
  nnoremap <coc>D  <Cmd>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <coc>e  <Cmd>CocList extensions<cr>
  " Show commands
  nnoremap <coc>c  <Cmd>CocList commands<cr>
  " Find symbol of current document
  nnoremap <coc>o  <Cmd>CocList outline<cr>
  " Search workLeader symbols
  nnoremap <coc>s  <Cmd>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <coc>j  <Cmd>CocNext<CR>
  " Do default action for previous item.
  nnoremap <coc>k  <Cmd>CocPrev<CR>
  " Resume latest coc list
  nnoremap <coc>p  <Cmd>CocListResume<CR>

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
  call coc#config('suggest.triggerCompletionWait', '100')
  call coc#config('suggest.triggerSignatureWait', '100')
  call coc#config('suggest.asciiCharactersOnly', 'true')
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
        \ 'cargo-watch.allTargets': 'true',
        \ 'lens.methodReferences': 'true',
        \ 'hoverActions.linksInHover': 'true',
        \ 'procMacro.enable': 'true'
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
  call coc#config('explorer.previewAction.onHover', 'content')
  call coc#config('session.directory', '~/.local/share/nvim/sessions')
  call coc#config('codeLens.enable', 'true')
  call coc#config('tabnine.priority', 50)
  call coc#config('cSpell.showStatus', 'false')
  call coc#config('project.dbpath', '~/.local/share/nvim/coc-project')
  call coc#config('translator', {
        \ 'toLang': 'ja',
        \ 'engines': [
        \   'google',
        \   'bing'
        \ ]})

  " coc-diagnostic
  "if executable('efm-langserver')
  "  call coc#config('languageserver.efm', {
  "        \ 'command': 'efm-langserver',
  "        \ 'args': [],
  "        \ 'filetypes': ['vim', 'eruby', 'markdown', 'yaml', 'sh']
  "        \})
  "  "   // custom config path
  "  "   // 'args': ['-c', '/path/to/your/config.yaml'],
  "endif


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
    nnoremap <Leader>y  <Cmd>CocList -A --normal yank<cr>
  endif

  if s:coc_plugin_is_installed('coc-git')
    " navigate chunks of current buffer
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    " navigate conflicts of current buffer
    nmap [c <Plug>(coc-git-prevconflict)
    nmap ]c <Plug>(coc-git-nextconflict)
    " show chunk diff at current position
    nmap <coc>gs <Plug>(coc-git-chunkinfo)
    " show commit contains current position
    nmap <coc>gc <Plug>(coc-git-commit)
    " create text object for git chunks
    omap ig <Plug>(coc-git-chunk-inner)
    xmap ig <Plug>(coc-git-chunk-inner)
    omap ag <Plug>(coc-git-chunk-outer)
    xmap ag <Plug>(coc-git-chunk-outer)
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
    nmap gx <Cmd>CocCommand explorer --width 30<CR>

    augroup vimrc_coc_explorer
      autocmd!
      autocmd VimEnter * sil! au! FileExplorer *
      autocmd BufEnter * let s:d = expand('%:p') | if vimrc#is_dir(s:d) | silent! bd | exe 'CocCommand explorer ' . s:d | endif
    augroup END
  endif

  if s:coc_plugin_is_installed('coc-spell-checker')
    command! CSpellAddWordToWorkspaceDictionary CocCommand cSpell.addWordToDictionary
  endif

  if s:coc_plugin_is_installed('coc-actions')
    function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <coc>a <Cmd>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <coc>a <Cmd>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
    xmap M <Cmd>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap M   <Cmd>execute 'CocCommand actions.open'<CR>
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

    let g:fzf_preview_git_files_command   = 'git ls-files --exclude-standard | while read line; do if [[ ! -L $line ]] && [[ -f $line ]]; then echo $line; fi; done'
    let g:fzf_preview_filelist_command = 'rg --files --hidden --no-messages -g \!"* *" -g \!".git"'
    let g:fzf_preview_dev_icons_limit = 5000
    let g:fzf_preview_cache_directory = expand('~/.cache/nvim/fzf_preview')
    let $BAT_THEME = 'gruvbox'
    let $BAT_STYLE = 'grid,header'
    let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox'
    let $FZF_DEFAULT_OPTS = '--color=bg+:#1d2021,bg:#1d2021,spinner:#d8a657,hl:#a9b665,fg:#d4be98,header:#928374,info:#89b482,pointer:#7daea3,marker:#d8a657,fg+:#d4be98,prompt:#e78a4e,hl+:#89b482'
    let g:fzf_preview_default_fzf_options = {
          \ '--reverse': v:true,
          \ '--preview-window': 'wrap',
          \ '--exact': v:true,
          \ '--no-sort': v:true,
          \ }

    if s:plug.is_installed('vim-devicons')
      let g:fzf_preview_use_dev_icons = 1
    endif
    let g:fzf_preview_quit_map = 1

    function! s:fzf_preview_settings() abort
      let g:fzf_preview_command = 'bat --color=always --style=grid,header {-1}'
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
      " let g:fzf_preview_default_fzf_options = { '--reverse': v:true }
    endfunction

    augroup vimrc_fzf_preview
      autocmd!
      autocmd User fzf_preview#coc#initialized call s:fzf_preview_settings()
    augroup END

    " conflict coc-fzf
    " let g:fzf_layout = {
    "       \ 'window': 'call fzf_preview#window#create_centered_floating_window()',
    "       \ }

    " Map
    nnoremap <fuzzy-finder>   <Nop>
    vnoremap <fuzzy-finder>   <Nop>
    nmap    z <fuzzy-finder>
    vmap    z <fuzzy-finder>

    xnoremap <CR>         "sy:CocCommand fzf-preview.ProjectGrep<Space>-F<Space><C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>
    nnoremap <Leader><Leader> <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>p    <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>.    <Cmd>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>;    <Cmd>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>'    <Cmd>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>,            :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    nnoremap <fuzzy-finder><fuzzy-finder> <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>p     <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>.     <Cmd>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>;     <Cmd>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>'     <Cmd>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right<CR>
    vnoremap <fuzzy-finder>,     y:CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=escape(@", '\\.*$^[]')<CR>"
    nnoremap <fuzzy-finder>,     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    nnoremap <fuzzy-finder>g     <Cmd>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder><C-g> <Cmd>CocCommand fzf-preview.GitActions --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader>g     <Cmd>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right<CR>
    nnoremap <Leader><C-g> <Cmd>CocCommand fzf-preview.GitActions --add-fzf-arg=--keep-right<CR>
    "nnoremap <fuzzy-finder>b     <Cmd>CocCommand fzf-preview.Buffers<CR>
    nnoremap <fuzzy-finder>b     <Cmd>CocCommand fzf-preview.Buffers --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>a     <Cmd>CocCommand fzf-preview.AllBuffers --add-fzf-arg=--keep-right<CR>
    nnoremap <fuzzy-finder>m     <Cmd>CocCommand fzf-preview.Marks<CR>
    nnoremap <Leader>*    <Cmd>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
    nnoremap <Leader>/    <Cmd>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'" --resume<CR>
    nnoremap <Leader>#    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=expand('<cword>')<CR>"
    nnoremap <fuzzy-finder>*     <Cmd>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
    nnoremap <fuzzy-finder>/     <Cmd>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
    nnoremap <fuzzy-finder>**    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=expand('<cword>')<CR>"
    nnoremap <fuzzy-finder><C-o> <Cmd>CocCommand fzf-preview.Jumps<CR>
    nnoremap <fuzzy-finder>j     <Cmd>CocCommand fzf-preview.Jumps<CR>
    nnoremap <fuzzy-finder>c     <Cmd>CocCommand fzf-preview.Changes<CR>
    nnoremap <fuzzy-finder>t     <Cmd>CocCommand fzf-preview.Ctags<CR>
    nnoremap <fuzzy-finder>tb    <Cmd>CocCommand fzf-preview.BufferTags --resume<CR>
    nnoremap <fuzzy-finder>q     <Cmd>CocCommand fzf-preview.QuickFix<CR>
    nnoremap <fuzzy-finder>l     <Cmd>CocCommand fzf-preview.LocationList<CR>
    nnoremap <Leader>gf   <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--select-1 --add-fzf-arg=--query="<C-r>=substitute(expand('<cfile>'), '^\.\+/', '', '')<CR>"<CR>

    nnoremap <fuzzy-finder>v     <Cmd>CocCommand fzf-preview.VistaCtags<CR>
    nnoremap <fuzzy-finder>vb    <Cmd>CocCommand fzf-preview.VistaBufferCtags<CR>
    nnoremap <fuzzy-finder>r     <Cmd>CocCommand fzf-preview.CocReferences<CR>
    nnoremap <fuzzy-finder>d     <Cmd>CocCommand fzf-preview.CocDiagnostics<CR>
    nnoremap <fuzzy-finder>c     <Cmd>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
    nnoremap <fuzzy-finder>n     <Cmd>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
    nnoremap <fuzzy-finder>h     <Cmd>CocCommand fzf-preview.CommandPalette<CR>

    " resume
    nnoremap <fuzzy-finder-resume>   <Nop>
    vnoremap <fuzzy-finder-resume>   <Nop>
    nmap    Z <fuzzy-finder-resume>
    vmap    Z <fuzzy-finder-resume>
    nnoremap <Leader>P    <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <Leader>>    <Cmd>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <Leader>:    <Cmd>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <Leader>"    <Cmd>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <Leader>,    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    nnoremap <fuzzy-finder-resume><fuzzy-finder-resume> <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>p     <Cmd>CocCommand fzf-preview.FromResources project_mru git --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>.     <Cmd>CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>;     <Cmd>CocCommand fzf-preview.MruFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>'     <Cmd>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>,     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
    vnoremap <fuzzy-finder-resume>.     y:CocCommand fzf-preview.ProjectGrep<Space>"<C-r>=escape(@", '\\.*$^[]') --resume<CR>"
    nnoremap <fuzzy-finder-resume>g     <Cmd>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>b     <Cmd>CocCommand fzf-preview.Buffers --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>a     <Cmd>CocCommand fzf-preview.AllBuffers --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>m     <Cmd>CocCommand fzf-preview.Marks --resume<CR>
    nnoremap <fuzzy-finder-resume>w     <Cmd>CocCommand fzf-preview.MrwFiles --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>g     <Cmd>CocCommand fzf-preview.GitStatus --add-fzf-arg=--keep-right --resume<CR>
    nnoremap <fuzzy-finder-resume>j     <Cmd>CocCommand fzf-preview.Jumps --resume<CR>
    nnoremap <fuzzy-finder-resume>c     <Cmd>CocCommand fzf-preview.Changes --resume<CR>
    nnoremap <fuzzy-finder-resume>t     <Cmd>CocCommand fzf-preview.Ctags --resume<CR>
    nnoremap <fuzzy-finder-resume>tb    <Cmd>CocCommand fzf-preview.BufferTags --resume --resume<CR>
    nnoremap <fuzzy-finder-resume>q     <Cmd>CocCommand fzf-preview.QuickFix --resume<CR>
    nnoremap <fuzzy-finder-resume>l     <Cmd>CocCommand fzf-preview.LocationList --resume<CR>
    nnoremap <fuzzy-finder-resume>n     <Cmd>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>

    " Command
    command! -bang FZFTodo FzfPreviewProjectGrep FIXME\|TODO<CR>
  endif

  "----------------
  " Other dependencies plugin

  "-------------------------------
  " coc-fzf
  if s:plug.is_installed('coc-fzf')
    call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'FZFBuffers')
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
  endif

  "-------------------------------
  " vim-skylight
  if s:plug.is_installed('vim-skyligh')
    nnoremap go <Cmd>SkylightJumpTo<CR>
    nnoremap gp <Cmd>SkylightPreview<CR>
  endif

endif

" }}}


" ------------------------------


