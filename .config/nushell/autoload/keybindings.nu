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

# zsh's beginning-of-line: at a line start, move to the start of the previous line instead.
def line-start-or-up [] {
  let before = commandline | str substring --grapheme-clusters ..<(commandline get-cursor)
  let trimmed = $before | str replace --regex '\n$' ''
  let current_line = $trimmed | split row (char nl) | last
  commandline set-cursor (($trimmed | str length --grapheme-clusters) - ($current_line | str length --grapheme-clusters))
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
  {
    name: line_start_or_up
    modifier: control
    keycode: char_a
    mode: [emacs vi_insert]
    event: {
      send: executehostcommand
      cmd: "line-start-or-up"
    }
  }
  # WezTerm sends Shift+Enter as LF, which reedline reads as Ctrl+J and runs as Enter by default.
  {
    name: shift_enter_newline
    modifier: control
    keycode: char_j
    mode: [emacs vi_insert]
    event: {edit: insertnewline}
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
