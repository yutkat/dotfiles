function! s:gruvbox_material_custom() abort
  let l:palette = gruvbox_material#get_palette('hard', 'mix')
  " Define a highlight group.
  " The first parameter is the name of a highlight group,
  " the second parameter is the foreground color,
  " the third parameter is the background color,
  " the fourth parameter is for UI highlighting which is optional,
  " and the last parameter is for `guisp` which is also optional.
  " See `autoload/gruvbox_material.vim` for the format of `l:palette`.
   call gruvbox_material#highlight('Cursor', l:palette.grey2, l:palette.grey2, 'none', l:palette.grey2)
endfunction

augroup GruvboxMaterialCustom
  autocmd!
  autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_disable_italic_comment = 1
" don't do highlight clear
let g:colors_name = 'gruvbox-material'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material
