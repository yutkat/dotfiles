# Function (not alias) so functions defined earlier (e.g. vc in function.zsh) resolve `vi` at call time.
function vi() {
	snvim "$@"
}
alias v='vi -c "SessionLoadCurrent"'

# snvim (firejail-sandboxed Neovim) lives in .local/bin/snvim so other shells can use it.
alias snvim-net='SNVIM_NET=1 snvim'
alias snvim-offline='SNVIM_NET=none snvim'
alias snvim-wall='SNVIM_NET=wall snvim'
