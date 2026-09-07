# Working Agreements

These are defaults; follow the user's request and more specific project guidance and conventions.

## Communication

- Reply in the user's language, lead with the outcome, and use short paragraphs; prefer numbered lists when useful.
- Write code comments and documentation in English; keep comments short and limited to non-obvious constraints.
- Do not add a License section to README files; use the LICENSE file.

## Changes

- Stay within the authorized scope and preserve existing intent and style; ask only about consequential ambiguity or unrequested scope expansion.
- For fixes, establish the cause first; do not broaden lint/CI targets or add global ignores just to make checks pass.
- When removing or renaming something, check its consumers, configuration names, hidden paths, and symlinks.
- Leave commits and pushes to the user; respect configured tool permissions.
- Never hardcode or expose secrets.
- Address recurring failures in code or tests where practical; propose persistent instruction changes instead of adding rules automatically.

## Verification

- Use existing project tooling, run checks relevant to the change and all required project checks, and rerun any modified lint/CI command itself.
- Report the result, verification performed, and any blockers or unverified behavior; do not claim completion while required checks remain blocked.
- For reviews, lead with findings ordered by severity and file references; state explicitly when there are none and note testing gaps.
