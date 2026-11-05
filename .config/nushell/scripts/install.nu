# Clone the plugin modules used by autoload/*.nu, which resolve their paths at parse time.
# Update them with `nu-modules-update` (autoload/modules.nu).
for module in [nu-autocomplete nu-cdpath nu-git-auto-fetch nu-auto-notify nu-abbr] {
  let dir = ($nu.data-dir | path join "modules" $module)
  if (which git | is-not-empty) and not ($dir | path exists) {
    try { ^git clone --quiet --depth 1 $"https://github.com/yutkat/($module)" $dir }
  }
}
