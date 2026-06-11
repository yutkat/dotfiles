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
read-write ${HOME}/.cache/zsh

blacklist ${HOME}/.aws
blacklist ${HOME}/.azure
blacklist ${HOME}/.config/gh
blacklist ${HOME}/.config/gcloud
blacklist ${HOME}/.docker
blacklist ${HOME}/.git-credentials
blacklist ${HOME}/.gnupg
blacklist ${HOME}/.kube
blacklist ${HOME}/.netrc
blacklist ${HOME}/.npmrc
blacklist ${HOME}/.password-store
blacklist ${HOME}/.pypirc
blacklist ${HOME}/.ssh
