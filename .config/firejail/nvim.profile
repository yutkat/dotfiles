# Base profile for the snvim zsh function.
# Network policy and project write access are added from zsh.

caps.drop all
nonewprivs
seccomp
seccomp.block-secondary
ipc-namespace
private-dev
disable-mnt

# Filesystem model: HOME is read-write by default (editing any file just works);
# only sensitive credential/secret paths are blacklisted (no read or write).
# Trade-off vs read-only HOME: a hijacked plugin can now modify files in HOME
# (persistence), but the egress wall still blocks exfil and secrets are hidden.
# Keep this blacklist comprehensive -- anything not listed is readable/writable.

# SSH / GPG / generic auth
blacklist ${HOME}/.ssh
blacklist ${HOME}/.gnupg
blacklist ${HOME}/.netrc
blacklist ${HOME}/.authinfo
blacklist ${HOME}/.authinfo.gpg
blacklist ${HOME}/.pgpass
blacklist ${HOME}/.git-credentials
blacklist ${HOME}/.config/git/credentials

# Cloud / infra
blacklist ${HOME}/.aws
blacklist ${HOME}/.azure
blacklist ${HOME}/.config/gcloud
blacklist ${HOME}/.kube
blacklist ${HOME}/.docker
blacklist ${HOME}/.terraform.d
blacklist ${HOME}/.config/doctl

# Dev registries / forge tokens (caches like ~/.npm, ~/.cargo stay writable)
blacklist ${HOME}/.npmrc
blacklist ${HOME}/.pypirc
blacklist ${HOME}/.gem/credentials
blacklist ${HOME}/.cargo/credentials
blacklist ${HOME}/.cargo/credentials.toml
blacklist ${HOME}/.config/gh
blacklist ${HOME}/.config/glab

# Password managers / secret stores / keyrings
blacklist ${HOME}/.password-store
blacklist ${HOME}/.config/sops
blacklist ${HOME}/.config/age
blacklist ${HOME}/.age
blacklist ${HOME}/.local/share/keyrings
blacklist ${HOME}/.gnome2/keyrings

# Browser profiles (cookies, sessions, saved passwords)
blacklist ${HOME}/.mozilla
blacklist ${HOME}/.config/vivaldi
blacklist ${HOME}/.config/google-chrome
blacklist ${HOME}/.config/chromium
blacklist ${HOME}/.config/BraveSoftware
