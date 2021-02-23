let g:rustfmt_autosave = 0
if executable('rustfmt')
  let g:rustfmt_command = 'rustfmt'
elseif filereadable($HOME . '/.cargo/bin/rustfmt')
  let g:rustfmt_command = $HOME . '/.cargo/bin/rustfmt'
elseif filereadable('/usr/bin/rustfmt')
  let g:rustfmt_command = '/usr/bin/rustfmt'
endif
let g:rust_clip_command = 'xclip -selection clipboard'
