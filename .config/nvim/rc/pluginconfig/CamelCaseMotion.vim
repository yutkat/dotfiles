nnoremap <silent> [SubLeader]w :<C-U>call camelcasemotion#Motion('w', v:count1, 'n')<CR>
nnoremap <silent> [SubLeader]b :<C-U>call camelcasemotion#Motion('b', v:count1, 'n')<CR>
nnoremap <silent> [SubLeader]e :<C-U>call camelcasemotion#Motion('e', v:count1, 'n')<CR>
nnoremap <silent> [SubLeader]ge :<C-U>call camelcasemotion#Motion('ge', v:count1, 'n')<CR>
onoremap <silent> ,w :<C-U>call camelcasemotion#InnerMotion('w', v:count1)<CR>
onoremap <silent> ,b :<C-U>call camelcasemotion#InnerMotion('b', v:count1)<CR>
onoremap <silent> ,e :<C-U>call camelcasemotion#InnerMotion('e', v:count1)<CR>
onoremap <silent> ,ge :<C-U>call camelcasemotion#InnerMotion('ge', v:count1)<CR>
xnoremap <silent> ,w :<C-U>call camelcasemotion#InnerMotion('w', v:count1)<CR>
xnoremap <silent> ,b :<C-U>call camelcasemotion#InnerMotion('b', v:count1)<CR>
xnoremap <silent> ,e :<C-U>call camelcasemotion#InnerMotion('e', v:count1)<CR>
xnoremap <silent> ,ge :<C-U>call camelcasemotion#InnerMotion('ge', v:count1)<CR>
