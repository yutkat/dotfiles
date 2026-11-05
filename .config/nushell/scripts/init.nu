# Generate tool init scripts once; delete a generated file to regenerate it after upgrading the tool.

# The vendor autoload dir is sourced after config.nu.
let vendor_autoload = ($nu.data-dir | path join "vendor/autoload")
let zoxide_init = ($vendor_autoload | path join "zoxide.nu")
if (which zoxide | is-not-empty) and not ($zoxide_init | path exists) {
  mkdir $vendor_autoload
  ^zoxide init --cmd j nushell | save -f $zoxide_init
}
# Kept out of autoload: autoload/nu-autocomplete.nu sources it so it can wrap the carapace completer.
let mise_completion = ($nu.data-dir | path join "completions/mise.nu")
if (which mise | is-not-empty) and not ($mise_completion | path exists) {
  mkdir ($mise_completion | path dirname)
  ^mise completion nu | save -f $mise_completion
}
