# Update commands for the plugin modules that scripts/install.nu clones into $nu.data-dir/modules.

# Update every git-managed module cloned into $nu.data-dir/modules; restart nu to load the changes.
def nu-modules-update [] {
  let modules = ($nu.data-dir | path join "modules")
  if not ($modules | path exists) { return }
  let repos = (ls $modules | where type == dir | get name | where { $in | path join ".git" | path exists })
  for repo in $repos {
    print $"Updating ($repo | path basename)"
    try { ^git -C $repo pull --ff-only --quiet }
  }
}

# Counterpart of zsh `plugupdate`; delegates to it because zinit and wall_run are zsh-only.
def plugupdate [] {
  print "Update nushell modules"
  nu-modules-update
  ^zsh -ic plugupdate
}
