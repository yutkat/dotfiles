# GitHub Actions

- Use `vars` (repository/organization variables) for non-sensitive configuration values
- Reserve `secrets` only for sensitive data (API keys, tokens, passwords, etc.)
- When updating action versions, never assume the latest from memory; verify with `gh api repos/<owner>/<action>/releases/latest` first
