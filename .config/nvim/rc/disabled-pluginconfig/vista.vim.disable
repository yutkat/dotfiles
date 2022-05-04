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

" augroup vimrc_vista
"   autocmd!
"   autocmd VimEnter * call MyRunForNearestMethodOrFunction()
" augroup END
