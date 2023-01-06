#!/bin/bash
# shellcheck disable=SC2034
# https://zenn.dev/odan/articles/17a86574b724c9
set -eu
{ for i in $(seq 1 10); do /usr/bin/time --format="%e" -o /dev/stdout zsh -li --rcs ~/.config/zsh/.zshrc -c exit; done; } >/tmp/zsh-load-time.txt 2>/dev/null
ZSH_LOAD_TIME=$(awk '{ total += $1 } END { print total/NR }' /tmp/zsh-load-time.txt)

{ for i in $(seq 1 10); do /usr/bin/time --format="%e" ~/.local/share/zsh/zinit/plugins/neovim---neovim/nvim-linux64/bin/nvim -c "qall"; done; } >/dev/null 2>/tmp/nvim-load-time.txt
NVIM_LOAD_TIME=$(awk '{ total += $1 } END { print total/NR }' /tmp/nvim-load-time.txt)

cat <<EOJ
[
    {
        "name": "zsh load time",
        "unit": "Second",
        "value": ${ZSH_LOAD_TIME}
    },
    {
        "name": "neovim load time",
        "unit": "Second",
        "value": ${NVIM_LOAD_TIME}
    }
]
EOJ
