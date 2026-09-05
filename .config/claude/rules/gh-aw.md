# GitHub Agentic Workflows (gh-aw)

- In `tools.bash`, allow commands with a bare name (`"jq"`) or `"jq *"`; entries with flags/args like `"jq -r"` compile to `shell(jq -r)` which Copilot CLI's matcher denies at runtime ("Permission denied and could not request permission from user")
- gh-aw already allowlists read-only basics by default (`cat`, `grep`, `head`, `ls`, `sort`, `tail`, `wc`, `yq`, ...); check the compiled `--allow-tool shell(...)` comments in the lock file before adding entries
- To debug an agent run, download the run artifacts (`gh run download <id>`) and read `agent/agent-stdio.log`; denied tool calls appear there even when the agent step itself reports success
- After editing a workflow `.md`, always rerun `gh aw compile` and verify the intended change appears in the generated lock file
