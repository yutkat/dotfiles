#!/bin/bash
# shellcheck disable=SC2034
# https://zenn.dev/odan/articles/17a86574b724c9
set -euo pipefail

export TERM="screen-256color"
# zsh
if [ -e "/tmp/zsh-bench" ]; then
	rm -rf "/tmp/zsh-bench"
fi
git clone --depth 1 https://github.com/romkatv/zsh-bench.git /tmp/zsh-bench
/tmp/zsh-bench/zsh-bench -i 1 | tee /tmp/zsh-bench.txt
first_prompt_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_prompt_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"
first_command_lag_ms="$(cat /tmp/zsh-bench.txt | grep 'first_command_lag_ms' | sed -n 's/.*=\(.*\)/\1/p')"

# neovim
if command -v nvim >/dev/null 2>&1; then
	{
		for i in $(seq 1 10); do
			nvim --headless -c 'lua vim.defer_fn(function()
          local ok, time = pcall(function() return require("lazy").stats().times.LazyDone end)
          if not ok or type(time) ~= "number" or time <= 0 or time == math.huge or time ~= time then
            io.stderr:write("Failed to measure Neovim startup: " .. tostring(time) .. "\n")
            vim.cmd("cquit 1")
            return
          end
          -- Write directly so message plugins cannot intercept the measurement.
          io.write(string.format("%.6f\n", time))
          io.flush()
          vim.cmd("qall")
        end, 100)'
		done
	} >/tmp/lazy-startup-times.txt

	NVIM_LOAD_TIME=$(awk '
        /^[0-9]+([.][0-9]+)?$/ { total += $1; count++ }
        END {
            if (NR != 10 || count != 10) {
                print "Expected 10 valid Neovim startup measurements, got " count >"/dev/stderr"
                exit 1
            }
            printf "%.2f", total / NR
        }
    ' /tmp/lazy-startup-times.txt)
	echo "Average startup time: ${NVIM_LOAD_TIME}ms"
else
	echo "Neovim not found; cannot measure startup time" >&2
	exit 1
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
