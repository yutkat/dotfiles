export EDITOR=nvim
alias vi='snvim'
alias sv="sudo $EDITOR"
alias v='nvim -c "PossessionLoadCurrent"'

# snvim (firejail-sandboxed Neovim) lives in .local/bin/snvim so other shells can use it.
alias snvim-net='SNVIM_NET=1 snvim'
alias snvim-offline='SNVIM_NET=none snvim'
alias snvim-wall='SNVIM_NET=wall snvim'
if (($+functions[compdef])); then
	compdef snvim=nvim
fi
