# Base profile for the snvim zsh function.
# Network policy and project write access are added from zsh.

caps.drop all
nonewprivs
seccomp
seccomp.block-secondary
ipc-namespace
private-tmp
private-dev
disable-mnt

read-only ${HOME}
read-write ${HOME}/.cache/nvim
read-write ${HOME}/.local/state/nvim
read-write ${HOME}/.wakatime

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
