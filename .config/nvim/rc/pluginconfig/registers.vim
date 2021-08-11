function! s:disable_registers_mappings() abort
  cunmap <C-r>
  nunmap "
endfunction

function! s:enable_registers_mappings() abort
  inoremap <silent> <C-r> <cmd>Registers i<CR>
endfunction

command! RegistersMappingDisable call s:disable_registers_mappings()
command! RegistersMappingEnable call s:enable_registers_mappings()
call s:disable_registers_mappings()
