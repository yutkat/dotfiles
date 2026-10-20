# Counterpart of zsh-abbrev-alias (.config/zsh/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh): expand on Space/Enter.
# https://github.com/yutkat/nu-abbr, cloned by config.nu; `use null` keeps startup working when the clone failed.
# The git aliases in aliases.nu stay as the fallback, like the alias zsh-abbrev-alias defines behind each abbreviation.
const nu_abbr = $nu.data-dir | path join modules nu-abbr nu-abbr
const nu_abbr_mod = if ($nu_abbr | path exists) { $nu_abbr } else { null }
use $nu_abbr_mod
if $nu_abbr_mod != null {
  nu-abbr add G "| grep"
  # "." at the repository root, no expansion outside a repository
  nu-abbr add "~~" {|| let p = (git rev-parse --show-cdup); if $p == "" { "." } else { $p } }

  # git
  nu-abbr add gc "git commit"
  nu-abbr add ga "git add ."
  nu-abbr add gb "git branch"
  nu-abbr add gd "git diff HEAD"
  nu-abbr add gs "git status --short"
  nu-abbr add gr "gh renew"
  nu-abbr add pr "try { gh pr view -w } catch { gh pr create -w }"

  nu-abbr enable
}
