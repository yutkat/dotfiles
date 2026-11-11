# Core settings and environment.

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
# Keep history out of this repository-linked directory.
$env.config.history.path = ($nu.data-dir | path join "history.txt")
$env.config.history.file_format = "plaintext"
$env.config.history.isolation = false
$env.config.completions.algorithm = "substring"

# Fallback when nu is not started from zsh (which sets these in .zshenv).
# Without XDG_DATA_HOME, rip2 (the rm alias) buries files in tmpfs /tmp.
$env.XDG_DATA_HOME = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
# mise uses shims rather than `mise activate`, whose hook runs on every prompt.
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append [
    ($env.HOME | path join ".local/bin")
    ($env.XDG_DATA_HOME | path join "mise/shims")
  ]
  | uniq
)
$env.EDITOR = "nvim"
