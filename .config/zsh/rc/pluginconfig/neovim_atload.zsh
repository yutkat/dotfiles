alias vi='snvim'
alias v='nvim -c "SessionLoadCurrent"'

# snvim (firejail-sandboxed Neovim) lives in .local/bin/snvim so other shells can use it.
alias snvim-net='SNVIM_NET=1 snvim'
alias snvim-offline='SNVIM_NET=none snvim'
alias snvim-wall='SNVIM_NET=wall snvim'
