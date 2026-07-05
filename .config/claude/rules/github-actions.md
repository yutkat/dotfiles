# GitHub Actions

- When creating a new standalone repository (e.g. a plugin), always add a CI workflow with at least lint/format checks, following the conventions of the user's existing sibling repositories
- Use `vars` (repository/organization variables) for non-sensitive configuration values
- Reserve `secrets` only for sensitive data (API keys, tokens, passwords, etc.)
- When updating action versions, never assume the latest from memory; verify with `gh api repos/<owner>/<action>/releases/latest` first
