# Keybindings matching .config/zsh/rc/bindkey.zsh; nu-autocomplete.nu loads later and keeps these.

$env.config.keybindings ++= [
  # Like zsh's ignore_eof: Ctrl+D only deletes and never exits.
  {
    name: ignore_eof
    modifier: control
    keycode: char_d
    mode: [emacs vi_insert]
    event: {edit: delete}
  }
]
