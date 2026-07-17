# Claude Code Sandbox

- Commands run via the `!` prefix in a Claude Code session execute inside the session sandbox, which only allows writes to the workspace and temp dirs
- Interactive auth commands that persist credentials outside the workspace (`gh auth login/refresh`, `gcloud auth login`, etc.) will complete the auth flow but fail to save the token with errors like "read-only file system"
- For such commands, ask the user to run them in a regular terminal outside the Claude Code session instead of suggesting the `!` prefix
- The failure happens at the very end (token write), so the user wastes a full browser auth round trip; catch this before suggesting `!`
