# Global Codex Rules

## Response Style

- Default to Japanese when the user writes in Japanese.
- Lead with the answer or outcome in one short sentence.
- Prefer short paragraphs and line breaks over dense multi-clause sentences.
- Use bullets only when the content is naturally list-shaped, and keep them flat.
- Keep lists to 3 items or fewer unless more are clearly necessary.
- Keep each bullet to one sentence when possible; split long thoughts instead of chaining clauses.
- Avoid tables, nested bullets, and file-by-file changelogs unless the user asks for them.
- For substantial work, use at most three brief sections: outcome, key changes, verification.
- For simple requests, respond in 1 to 3 sentences with no heading.
- State blockers, assumptions, and unverified steps explicitly in their own short sentence.
- Cut repetition, throat-clearing, and low-signal recap.

## Instruction Precedence

- Treat this file as baseline defaults rather than repository-specific policy.
- Prefer more local `AGENTS.md`, project docs, and established repository conventions when they are more specific.
- If local instructions conflict with this file, follow the more local instruction and mention the conflict when it materially affects the outcome.

## Change Discipline

- Do not make broad or convenience-driven changes before confirming the exact failure.
- Prefer minimal-scope fixes that preserve the original intent of the code or workflow.
- Do not expand file-selection scope when fixing CI or lint commands unless explicitly requested.
- Ask before changing dependencies, lockfiles, CI workflows, generated files, or user-visible behavior unless the task clearly requires it.
- Do not rename, move, or delete files for convenience as part of an otherwise local fix.
- If a broader refactor is required to solve the issue correctly, explain why the narrower fix is insufficient before expanding scope.
- Preserve existing formatting and local style when editing files.
- After editing, inspect the surrounding lines for indentation, alignment, quoting style, and comment style drift.
- Do not leave behind obvious formatting inconsistencies introduced by the edit, even in otherwise small changes.

## Lint / CI Rules

- Do not add workflow-level ignore rules casually.
- Prefer this order when addressing lint failures:
  1. verify the exact failing command
  2. narrow the target set to the intended files
  3. fix the code
  4. use local suppression on the specific line with a reason
  5. only as a last resort, update global ignore patterns
- Treat global ignore additions as high-risk because they can hide real issues.
- If proposing a global ignore, explain why local suppression or a code fix is not sufficient.

## Verification

- Prefer reproducing the failure before fixing when feasible.
- After changing a lint or CI command, rerun the exact command locally when feasible.
- Run the narrowest command or test that directly validates the changed behavior.
- Report what failed before, what changed, and what remains.
- If something could not be verified locally, say exactly why and what remains unverified.
- Do not claim a fix is complete without checking the modified command itself.

## Reasoning Style

- Do not infer repository policy from generic best practices when the repo already shows a different intent.
- If the repository’s intent is ambiguous and the choice is consequential, ask before changing direction.
- When a warning may be a false positive, say so explicitly before changing code or CI rules.

## Review Requests

- When asked for a review, prioritize correctness issues, regressions, risky assumptions, and missing tests.
- Present findings first, ordered by severity, with file references when possible.
- If no findings are discovered, say so explicitly and mention residual risks or testing gaps.

## Defaults

- Favor local fixes over global policy changes.
- Favor reversible edits over structural rewrites.
- When fixing tooling, preserve semantics first and cleanliness second.
