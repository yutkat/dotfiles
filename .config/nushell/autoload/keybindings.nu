# Keybindings matching .config/zsh/rc/bindkey.zsh; nu-autocomplete.nu loads later and keeps these.

# fzf's default layout keeps the query and newest entries at the bottom, where the prompt is.
def history-pick [] {
  let entries = open $nu.history-path | lines | reverse | uniq
  let picked = if (which fzf | is-not-empty) {
    $entries | str join (char nl)
    | ^fzf --height 40% --layout default --scheme history --query (commandline)
    | complete | get stdout | str trim --right --char (char nl)
  } else {
    $entries | input list --fuzzy | default ""
  }
  # Plaintext history stores embedded newlines as <\n>.
  if ($picked | is-not-empty) {
    commandline edit --replace ($picked | str replace --all '<\n>' (char nl))
  }
}

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
      cmd: "history-pick"
    }
  }
]
