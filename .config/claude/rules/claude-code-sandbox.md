# Claude Code Sandbox

- Commands run via the `!` prefix in a Claude Code session execute inside the session sandbox, which only allows writes to the workspace and temp dirs
- Interactive auth commands that persist credentials outside the workspace (`gh auth login/refresh`, `gcloud auth login`, etc.) will complete the auth flow but fail to save the token with errors like "read-only file system"
- For such commands, ask the user to run them in a regular terminal outside the Claude Code session instead of suggesting the `!` prefix
- The failure happens at the very end (token write), so the user wastes a full browser auth round trip; catch this before suggesting `!`
- The sandbox overlays protected paths (project `.claude/*` config files, `.mcp.json`, `$HOME` shell/config files) with `/dev/null` device mounts, so `git status` run inside the sandbox lists them as untracked; they are sandbox artifacts, not real files — tell the user instead of assuming someone created them
- Before Claude Code 2.1.220 the overlay used real 0-byte files, and killing a sandboxed background task externally (e.g. `pkill`) left them behind on disk; prefer TaskStop for stopping background tasks regardless
