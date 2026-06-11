# Base profile for the snvim zsh function.
# Network policy and project write access are added from zsh.

caps.drop all
nonewprivs
seccomp
seccomp.block-secondary
ipc-namespace
private-dev
disable-mnt

read-only ${HOME}
read-write ${HOME}/.cache
read-write ${HOME}/.local/state/nvim
read-write ${HOME}/.local/share/nvim
read-write ${HOME}/.wakatime
# Package-manager caches so Mason's npm/pip/cargo/go installers can write
# (installs land in ~/.local/share/nvim/mason; these are their scratch caches).
read-write ${HOME}/.npm
read-write ${HOME}/.cargo
read-write ${HOME}/.rustup
read-write ${HOME}/go

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
