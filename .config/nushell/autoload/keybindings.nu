# Keybindings matching .config/zsh/rc/bindkey.zsh; nu-autocomplete.nu loads later and keeps these.

# fzf's default layout keeps the query and newest entries at the bottom, where the prompt is.
def history-pick [] {
  # `history` works for both plaintext and SQLite history files.
  let entries = history | get command | reverse | uniq
  let picked = if (which fzf | is-not-empty) {
    # NUL-separated so multi-line commands (stored with real newlines in SQLite) stay one entry.
    $entries | str join (char nul)
    | ^fzf --read0 --print0 --height 40% --layout default --scheme history --query (commandline)
    | complete | get stdout | str trim --right --char (char nul)
  } else {
    $entries | input list --fuzzy | default ""
  }
  # Entries imported from plaintext history store embedded newlines as <\n>.
  if ($picked | is-not-empty) {
    commandline edit --replace ($picked | str replace --all '<\n>' (char nl))
  }
}

# fzf's Ctrl+T file widget, using the zsh FZF_CTRL_T_COMMAND/OPTS (fzf_atload.zsh).
def file-pick [] {
  let preview = if (which fzf-preview.sh | is-not-empty) { [--preview "fzf-preview.sh {}"] } else { [] }
  let picked = ^fd --hidden --follow --exclude .git
    | ^fzf --multi --height 40% --reverse --scheme path --keep-right ...$preview
    | complete | get stdout | lines
  if ($picked | is-not-empty) {
    let args = $picked | each {|p| if ($p =~ '^[\w./+-]+$') { $p } else { $p | to nuon } }
    commandline edit --insert ($args | str join " ")
  }
}

# zsh's smart-insert-last-word: insert the last word of the previous command; repeat to step back further.
def --env insert-last-word [] {
  let line = commandline
  let cursor = commandline get-cursor
  let state = $env.INSERT_LAST_WORD? | default {}
  let repeat = $state.line? == $line and $state.cursor? == $cursor
  let start = if $repeat { $state.start } else { $cursor }
  let from = if $repeat { $state.index + 1 } else { 0 }
  # Same filter as the zsh zstyle: words of 2+ characters containing a letter, / or \.
  let found = history | get command | reverse | enumerate | skip $from
    | each {|e|
      let word = ast --flatten $e.item | get content
        | where {|w| ($w | str length --grapheme-clusters) >= 2 and $w =~ '[\p{Alphabetic}/\\]' }
        | last 1 | get 0?
      if $word != null { {index: $e.index, word: $word} }
    }
    | first 1 | get 0?
  if $found == null { return }
  let before = $line | str substring --grapheme-clusters ..<$start
  let after = $line | str substring --grapheme-clusters $cursor..
  let new_cursor = $start + ($found.word | str length --grapheme-clusters)
  commandline edit --replace $"($before)($found.word)($after)"
  commandline set-cursor $new_cursor
  $env.INSERT_LAST_WORD = {line: (commandline), cursor: $new_cursor, start: $start, index: $found.index}
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
  {
    name: insert_last_word
    modifier: control
    keycode: "char_]"
    mode: [emacs vi_insert]
    event: {
      send: executehostcommand
      cmd: "insert-last-word"
    }
  }
  # Terminals send Ctrl+] as the legacy 0x1D byte, which crossterm decodes as Ctrl+5.
  {
    name: insert_last_word_legacy
    modifier: control
    keycode: char_5
    mode: [emacs vi_insert]
    event: {
      send: executehostcommand
      cmd: "insert-last-word"
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
  {
    name: file_pick
    modifier: control
    keycode: char_t
    mode: [emacs vi_insert]
    event: {
      send: executehostcommand
      cmd: "file-pick"
    }
  }
]
