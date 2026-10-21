# Complete `j` (zoxide, initialized in config.nu) with zoxide's directories, most frecent first.
def "nu-complete zoxide" [] {
  let home = $nu.home-dir
  let dirs = (
    ^zoxide query --list --exclude $env.PWD
    | lines
    | each {|dir| if ($dir | str starts-with $home) { $dir | str replace $home "~" } else { $dir } }
  )
  # Keep zoxide's order; match anywhere so "dotf" finds "~/dotfiles".
  {options: {sort: false, completion_algorithm: substring}, completions: $dirs}
}

def --env --wrapped j [...rest: string@"nu-complete zoxide"] {
  __zoxide_z ...$rest
}
