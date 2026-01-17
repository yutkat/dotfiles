#!/bin/bash
# shellcheck disable=SC2034
# https://zenn.dev/odan/articles/17a86574b724c9
set -eu

export TERM="screen-256color"
# zsh
if [ -e "/tmp/zsh-bench" ]; then
  rm -rf "/tmp/zsh-bench"
fi
git clone --depth 1  https://github.com/romkatv/zsh-bench.git /tmp/zsh-bench
/tmp/zsh-bench/zsh-bench -i 1 | tee /tmp/zsh-bench.txt
first_prompt_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_prompt_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"
first_command_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_command_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"

# neovim
if command -v nvim >/dev/null 2>&1; then
  { 
      for i in $(seq 1 10); do 
        nvim --headless -c 'lua vim.defer_fn(function()
          local stats = require("lazy").stats()
          print(vim.inspect(stats))
          vim.cmd("qall")
        end, 100)' 2>&1 | grep "LazyDone" | sed 's/.*LazyDone = \([0-9.]*\).*/\1/'
      done
  } > /tmp/lazy-startup-times.txt

  NVIM_LOAD_TIME=$(awk '{ total += $1; count++ } END { if (count > 0) printf "%.2f", total/count; else print "0" }' /tmp/lazy-startup-times.txt)
  echo "Average startup time: ${NVIM_LOAD_TIME}ms"
else
  echo "Neovim not found, using default value"
  NVIM_LOAD_TIME=1000  # Default fallback value
fi

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
