# Nushell config; files in autoload/ are sourced after this file.

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
# Keep history out of this repository-linked directory.
$env.config.history.path = ($nu.data-dir | path join "history.txt")
$env.config.history.file_format = "plaintext"
$env.config.history.isolation = false
$env.config.completions.algorithm = "fuzzy"
$env.config.rm.always_trash = true

# Fallback when nu is not started from zsh (which sets these in .zshenv).
# mise uses shims rather than `mise activate`, whose hook runs on every prompt.
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append [
    ($env.HOME | path join ".local/bin")
    ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share") | path join "mise/shims")
  ]
  | uniq
)
$env.EDITOR = "nvim"

# Generated init scripts go to the vendor autoload dir, which is sourced after this file.
# Delete the file to regenerate it after upgrading the tool.
let vendor_autoload = ($nu.data-dir | path join "vendor/autoload")
let zoxide_init = ($vendor_autoload | path join "zoxide.nu")
if (which zoxide | is-not-empty) and not ($zoxide_init | path exists) {
  mkdir $vendor_autoload
  ^zoxide init --cmd j nushell | save -f $zoxide_init
}
