# Working Agreements

These are defaults; follow the user's request and more specific project guidance and conventions.

## Communication

- Reply in the user's language, lead with the outcome, and use short paragraphs; prefer numbered lists when useful.
- In prose, always separate English words and identifiers from surrounding non-English text and punctuation with an ASCII space on each side; place these spaces outside inline code and link markup.
- Write code comments and documentation in English; keep comments short and limited to non-obvious constraints.
- Do not add a License section to README files; use the LICENSE file.
- When the user should run a command themselves next, put it in one fenced code block whose info string ends with `copy` (e.g. ` ```sh copy `); a Stop hook copies the last such block of the final reply to the primary selection. Mark at most one block per reply, never examples, logs, or reference code.

## Changes

- Stay within the authorized scope and preserve existing intent and style; ask only about consequential ambiguity or unrequested scope expansion.
- Keep changes minimal: no unrequested refactors, configurability, one-off abstractions, or handling for cases that cannot happen, because every extra line is something the user must review and maintain.
- Read the relevant files before answering about or changing code; do not make claims about code you have not opened.
- For fixes, establish the cause first; do not broaden lint/CI targets or add global ignores just to make checks pass.
- Solve the general problem rather than special-casing test inputs; if a test or check itself looks wrong, report it instead of working around it.
- Confirm before destructive, hard-to-reverse, or externally visible actions (deleting branches, `git reset --hard`, force pushes, posting comments); do not bypass safety checks such as `--no-verify`, and leave unfamiliar files alone because they may be the user's in-progress work.
- Remove temporary scripts and files created for iteration before finishing.
- When removing or renaming something, check its consumers, configuration names, hidden paths, and symlinks.
- Leave commits and pushes to the user; respect configured tool permissions.
- After making changes, end the report with a sample commit message that follows the repository's commit conventions.
- Never hardcode or expose secrets.
- Address recurring failures in code or tests where practical; propose persistent instruction changes instead of adding rules automatically.

## Verification

- Use existing project tooling, run checks relevant to the change and all required project checks, and rerun any modified lint/CI command itself.
- Report the result, verification performed, and any blockers or unverified behavior; do not claim completion while required checks remain blocked.
- For reviews, lead with findings ordered by severity and file references; state explicitly when there are none and note testing gaps.
