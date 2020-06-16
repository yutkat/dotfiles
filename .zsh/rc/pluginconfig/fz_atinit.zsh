FZ_HISTORY_CD_CMD=zshz
FZ_CMD=j
FZ_SUBDIR_CMD=jj

if builtin command -v auto-fu > /dev/null 2>&1; then
  __fz_zsh_default_completion=afu+complete-word
fi
if builtin command -v autocomplete > /dev/null 2>&1; then
  __fz_zsh_default_completion=menu-complete
fi
