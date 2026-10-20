# Counterpart of zsh-auto-notify: desktop notification when a long-running command finishes.
# https://github.com/yutkat/nu-auto-notify, cloned by config.nu; `use null` keeps startup working when the clone failed.
const nu_auto_notify = $nu.data-dir | path join modules nu-auto-notify nu-auto-notify
const nu_auto_notify_mod = if ($nu_auto_notify | path exists) { $nu_auto_notify } else { null }
use $nu_auto_notify_mod
if $nu_auto_notify_mod != null { nu-auto-notify enable --threshold 20sec --also-ignore [docker bat] }
