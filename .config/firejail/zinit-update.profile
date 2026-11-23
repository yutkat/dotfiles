# Profile for `zinit update` run behind the egress wall (wall_run).
# zinit fetches plugin code + gh-r release binaries and runs atclone/atpull
# build hooks -- a supply-chain code-execution surface. Confine it like nvim:
# read-only $HOME except zinit's data/cache dirs, secrets blacklisted.
caps.drop all
nonewprivs
seccomp
ipc-namespace
private-tmp
private-dev
disable-mnt

read-only ${HOME}
read-write ${HOME}/.local/share/zsh
read-write ${HOME}/.cache/mise
read-write ${HOME}/.cache/zsh

blacklist ${HOME}/.age
blacklist ${HOME}/.authinfo
blacklist ${HOME}/.authinfo.gpg
blacklist ${HOME}/.aws
blacklist ${HOME}/.azure
blacklist ${HOME}/.cargo/credentials
blacklist ${HOME}/.cargo/credentials.toml
blacklist ${HOME}/.claude
blacklist ${HOME}/.codex
blacklist ${HOME}/.config/BraveSoftware
blacklist ${HOME}/.config/age
blacklist ${HOME}/.config/claude
blacklist ${HOME}/.config/codex
blacklist ${HOME}/.config/doctl
blacklist ${HOME}/.config/gcloud
blacklist ${HOME}/.config/gh
blacklist ${HOME}/.config/git/credentials
blacklist ${HOME}/.config/glab
blacklist ${HOME}/.config/google-chrome
blacklist ${HOME}/.config/chromium
blacklist ${HOME}/.config/npm/npmrc
blacklist ${HOME}/.config/sops
blacklist ${HOME}/.config/vivaldi
blacklist ${HOME}/.docker
blacklist ${HOME}/.gem/credentials
blacklist ${HOME}/.git-credentials
blacklist ${HOME}/.gnome2/keyrings
blacklist ${HOME}/.gnupg
blacklist ${HOME}/.kube
blacklist ${HOME}/.local/share/keyrings
blacklist ${HOME}/.mozilla
blacklist ${HOME}/.netrc
blacklist ${HOME}/.npmrc
blacklist ${HOME}/.password-store
blacklist ${HOME}/.pgpass
blacklist ${HOME}/.pypirc
blacklist ${HOME}/.ssh
blacklist ${HOME}/.terraform.d
