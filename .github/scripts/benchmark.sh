#!/bin/bash
# shellcheck disable=SC2034
# https://zenn.dev/odan/articles/17a86574b724c9
set -eu

# zsh
if [ -e "/tmp/zsh-bench" ]; then
  rm -rf "/tmp/zsh-bench"
fi
git clone --depth 1  https://github.com/romkatv/zsh-bench.git /tmp/zsh-bench
ZSHRC_BENCH=true /tmp/zsh-bench/zsh-bench -i 1 | tee /tmp/zsh-bench.txt
first_prompt_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_prompt_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"
first_command_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_command_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"

# neovim
{ for i in $(seq 1 10); do /usr/bin/time --format="%e" ~/.local/share/zsh/zinit/plugins/neovim---neovim/nvim-linux64/bin/nvim --headless -c "qall"; done; } >/dev/null 2>/tmp/nvim-load-time.txt
NVIM_LOAD_TIME=$(awk '{ total += $1 } END { print total*1000/NR }' /tmp/nvim-load-time.txt)

# result
cat <<EOJ | tee /tmp/result-benchmark.json
[
    {
        "name": "zsh first prompt",
        "unit": "ms",
        "value": ${first_prompt_lag_ms}
    },
    {
        "name": "zsh first command",
        "unit": "ms",
        "value": ${first_command_lag_ms}
    },
    {
        "name": "neovim load time",
        "unit": "ms",
        "value": ${NVIM_LOAD_TIME}
    }
]
EOJ
