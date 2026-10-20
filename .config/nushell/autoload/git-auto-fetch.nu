# Counterpart of zsh's myplugins/git-auto-fetch.zsh: background `git fetch` at most every 5 minutes per repository.
# https://github.com/yutkat/nu-git-auto-fetch, cloned by config.nu; `use null` keeps startup working when the clone failed.
const nu_git_auto_fetch = $nu.data-dir | path join modules nu-git-auto-fetch nu-git-auto-fetch
const nu_git_auto_fetch_mod = if ($nu_git_auto_fetch | path exists) { $nu_git_auto_fetch } else { null }
use $nu_git_auto_fetch_mod
if $nu_git_auto_fetch_mod != null { nu-git-auto-fetch enable }
