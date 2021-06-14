function! s:disable_registers_mappings() abort
  nunmap "
  xunmap "
endfunction

function! s:enable_registers_mappings() abort
  nnoremap <silent> " <cmd>Registers n<CR>
  xnoremap <silent> " <esc><cmd>Registers v<CR>
endfunction

command! RegistersMappingDisable call s:disable_registers_mappings()
command! RegistersMappingEnable call s:enable_registers_mappings()
