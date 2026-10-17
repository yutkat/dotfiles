# Carapace completions for external commands; fall back to file completion when it has none.
$env.config.completions.external.enable = true
$env.config.completions.external.completer = {|place|
  let candidates = try {
    CARAPACE_LENIENT=1 carapace $place.command.0 nushell ...$place.command | from json
  } catch { null }
  if ($candidates | is-empty) { null } else { $candidates }
}

# https://github.com/yutkat/nu-autocomplete, cloned by config.nu; `use null` keeps startup working when the clone failed.
const nu_autocomplete = $nu.data-dir | path join modules nu-autocomplete nu-autocomplete
const nu_autocomplete_mod = if ($nu_autocomplete | path exists) { $nu_autocomplete } else { null }
use $nu_autocomplete_mod
if $nu_autocomplete_mod != null { nu-autocomplete enable }
