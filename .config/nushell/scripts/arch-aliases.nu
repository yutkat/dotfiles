# Arch Linux counterparts of .config/zsh/rc/alias.zsh; sourced from autoload/aliases.nu only on Arch.

# install
alias pac-update = ^sudo pacman -Sy
alias pac-upgrade = ^sudo pacman -Syu
alias pac-upgrade-force = ^sudo pacman -Syyu
alias pac-install = ^sudo pacman -S
alias pac-remove = ^sudo pacman -Rs
# search remote package
alias pac-search = ^pacman -Ss
alias pac-package-info = ^pacman -Si
# search local package
alias pac-installed-list = ^pacman -Qs
alias pac-installed-package-info = ^pacman -Qi
alias pac-installed-list-export = ^pacman -Qqen
alias pac-installed-files = ^pacman -Ql
alias pac-unused-list = ^pacman -Qtdq
alias pac-search-from-path = ^pacman -Qqo
# search package from filename
alias pac-included-files = ^pacman -Fl
alias pac-search-by-filename = ^pkgfile
# log
def pac-log [] {
  open --raw /var/log/pacman.log | lines | where $it =~ 'installed|removed|upgraded'
}
alias pac-aur-packages = ^pacman -Qm
# etc
alias pac-clean = ^sudo pacman -Scc
def pac-get-update-pkg [] {
  ^pacman -Si ...(^pacman -Su --print --print-format %n | lines)
}
alias pac-dependency = ^pacman -Qoq
# aur
alias paru-installed-list = ^paru -Qm
alias paru-clean = ^paru -Sc
def --wrapped yay [...args] {
  with-env {PATH: ($env.PATH | where $it !~ nix)} { ^yay ...$args }
}
