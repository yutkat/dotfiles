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
  # zsh-autosuggestions' autosuggest-accept; nu-autocomplete's Ctrl+Y accept falls back to this without a selection.
  {
    name: history_hint_accept
    modifier: control
    keycode: char_y
    mode: [emacs vi_insert]
    event: {send: historyhintcomplete}
  }
  # Fuzzy picker instead of the history menu, whose Enter conflicts with nu-autocomplete; inserts without running.
  {
    name: history_pick
    modifier: control
    keycode: char_r
    mode: [emacs vi_insert]
    event: {
      send: executehostcommand
      cmd: "commandline edit --replace (open $nu.history-path | lines | reverse | uniq | input list --fuzzy | default (commandline))"
    }
  }
]
