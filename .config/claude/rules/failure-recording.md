# Failure Recording

When a task fails, produces incorrect results, or requires correction by the user, automatically perform the following:

1. **Analyze**: Briefly identify the root cause of the failure
2. **Record**: If the failure pattern is generic and likely to recur, add a rule to the appropriate file in `~/.claude/rules/`:
   - Add to an existing rule file if the failure relates to an existing category (e.g., security issue -> `security.md`)
   - Create a new rule file only if no existing category fits
3. **Update index**: If a new rule file is created, update `CLAUDE.md` to reference it

## What to record

- Incorrect assumptions that led to the failure
- Misuse of tools, APIs, or language features
- Patterns that caused bugs or regressions
- Environment-specific gotchas discovered through failure

## What NOT to record

- One-off typos or trivial mistakes
- Failures caused by external system outages
- User-specific preferences (use memory instead)
