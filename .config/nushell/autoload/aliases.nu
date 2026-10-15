# Counterparts of .config/zsh/rc/alias.zsh that fit Nushell.

alias vi = nvim
alias hx = helix
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias cl = clear
alias quit = exit
alias t = tmux -2
alias ta = tmux -2 attach -d

# cd to the git repository root
def --env cdr [] {
  cd (^git rev-parse --show-toplevel)
}
