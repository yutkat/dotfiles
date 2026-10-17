# Directory helpers matching the zsh setup (chpwd ls_abbrev, zsh-dir-history, up).

# List the new directory after cd; long listings show only both ends.
def ls-abbrev [] {
  let result = (
    with-env {COLUMNS: ((term size).columns | into string)} { ^ls -CF --show-control-char --color=always }
    | lines
    | where $it !~ '^\e\[[0-9;]*m$'
  )
  if ($result | length) > 50 {
    $result | first 10 | each { print $in } | ignore
    print "......"
    $result | last 10 | each { print $in } | ignore
    print $"(ansi yellow_bold)(ls -a | length) files exist(ansi reset)"
  } else {
    $result | each { print $in } | ignore
  }
}

# Browser-style back/forward over visited directories (Ctrl+Shift+Left/Right).
const dir_history_max = 100
$env.__dir_history = {stack: [$env.PWD], index: 0}

# Back/forward set the index before cd, so the PWD hook sees the current entry and skips it.
def --env dir-history-go [step: int] {
  mut h = $env.__dir_history
  loop {
    let i = $h.index + $step
    if $i < 0 or $i >= ($h.stack | length) { break }
    let target = ($h.stack | get $i)
    if ($target | path type) == "dir" {
      $env.__dir_history = ($h | update index $i)
      cd $target
      return
    }
    $h.stack = ($h.stack | drop nth $i)
    if $step < 0 { $h.index -= 1 }
  }
  $env.__dir_history = $h
}

def --env dir-history-push [dir: string] {
  let h = $env.__dir_history
  if ($h.stack | get $h.index) == $dir { return }
  let stack = ($h.stack | first ($h.index + 1) | append $dir | last $dir_history_max)
  $env.__dir_history = {stack: $stack, index: (($stack | length) - 1)}
}

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD? | default [] | append {|before, after|
    # The hook also fires once at startup with no previous directory.
    if $before != null {
      dir-history-push $after
      ls-abbrev
    }
  }
)

$env.config.keybindings ++= [
  {
    name: dir_history_back
    modifier: control_shift
    keycode: left
    mode: [emacs vi_insert vi_normal]
    event: {send: executehostcommand cmd: "dir-history-go -1"}
  }
  {
    name: dir_history_forward
    modifier: control_shift
    keycode: right
    mode: [emacs vi_insert vi_normal]
    event: {send: executehostcommand cmd: "dir-history-go 1"}
  }
]

# cd up N levels
def --env up [n: int = 1] {
  cd (1..$n | each { ".." } | path join)
}
