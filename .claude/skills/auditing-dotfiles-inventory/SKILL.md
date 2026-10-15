---
name: auditing-dotfiles-inventory
description: >-
  Use when asked whether zsh plugins, Neovim plugins, or mise-managed tools in
  this dotfiles repo are still needed, unused, redundant, broken, outdated, or
  worth pruning (inventory, cleanup, audit, "do I still need X").
---

# Auditing the Dotfiles Inventory

## Overview

Decide **Keep / Remove / Fix / Watch** for every zsh plugin, Neovim plugin and mise tool, each backed by evidence gathered on this machine. Research only: change nothing until the user picks items.

For Neovim _alternatives_ (a better plugin), use the `suggest-neovim-plugin-alternatives` skill; this skill asks "is it still needed at all?".

## Sources of Truth

| Area   | Enabled items                                                                                                                                                                    | Wiring                                                                      |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Neovim | `XDG_CACHE_HOME=$TMPDIR/cache nvim --headless +'lua vim.defer_fn(function() for _,p in ipairs(require("lazy").plugins()) do io.write(p.url,"\n") end vim.cmd("qa!") end, 2000)'` | `.config/nvim/lua/rc/pluginlist.lua`, `rc/pluginconfig/`, `after/ftplugin/` |
| zsh    | uncommented `zinit` entries in `.config/zsh/rc/pluginlist.zsh`                                                                                                                   | `rc/pluginconfig/*_atload.zsh`, `rc/myplugins/`                             |
| mise   | `[tools]` in `.config/mise/config.toml` and `conf.d/*.toml`; compare with `mise ls`                                                                                              | `.mise/tasks/zsh-completions-sync`, aliases, `.gitignore`                   |

Commented-out specs are not loaded; never count them.

mise scope extras: entries from the gitignored `config.local.toml` are machine-local (list them separately, don't propose repo edits); an empty source in `mise ls` only means "not referenced from this directory": other projects may still use the install, and `mise prune` keeps anything referenced by a tracked config. Find users with `for l in ~/.local/state/mise/tracked-configs/*; do grep -Hn TOOL "$(readlink "$l")"; done` (runtimes like python also come from `.python-version` via `idiomatic_version_file_enable_tools`); report such installs as kept, not as prune candidates; lint tools are pinned in `.mise/tasks/lint` (`#MISE tools=`). Avoid `mise outdated` (blocked in the sandbox).

## Checks per Item

1. **Actually used?** Look for evidence, not intent: keymaps/commands/`bindkey` wired to it, data dirs it writes (e.g. `~/.ghg` absent ⇒ never used), and run its list/status command. Configs often hold stale absolute paths (old `/home/<user>/…`) or read caches that no longer exist, so the tool silently fails; report those as Fix and let the user decide.
   - **Missing usage evidence never proves "unused".** Rarely used tools and tools launched outside the shell leave no trace. Without objective proof (broken, or fully duplicated), put the item in Watch and ask.
   - For CLIs, count invocations in both the global zsh history (`~/.local/share/zsh/zsh_history`) and the per-directory histories (`~/.cache/zsh/zsh_history_dirs/**/zsh-per-directory-history`, from per-directory-history). About 38.8k global lines share the import timestamp `1768614945` (2026-01-17): read those as "used before then", not "last used then".
   - Check launchers outside the shell: editor plugins that spawn CLIs (e.g. sidekick.nvim's `cli.tools` includes `copilot`), scripts, other tools' configs. Grep enabled plugins (including their default configs) and the repo for the binary name (e.g. vim-wakatime runs `wakatime-cli` from PATH).
   - A completion line in `zsh-completions-sync` is not evidence of use.
2. **Superseded?** Neovim: check `nvim --version`, then grep `$VIMRUNTIME/doc` for the help tag; report "experimental" warnings. zsh: a tool's own integration (`fzf --zsh`, `zoxide init`) or a zsh option. mise: another tool or backend already doing the job (mise `github:`/`aqua:` backends replace release-downloaders; `delta` vs `difftastic`).
3. **Duplicated?** Two enabled items owning the same key or job (`f`/`t` hints, matchparen highlight, Tab completion). Read the other plugin's _defaults in its source_, not its README.
4. **Upstream health:** `gh api repos/OWNER/REPO --jq '{archived, pushed_at, stargazers_count}'` (≤20 calls). Stale but working ⇒ Watch, not Remove.
5. **Libraries** (nui, plenary, nvim-nio, …): list consumers by grepping `require("lib` only inside enabled plugins' `lua/` dirs. Discard hits from plugins without `lua/` (grep warnings, not real users).

Run Neovim, zsh and mise as parallel research-only subagents when auditing all three.

## Report

Reply in the user's language. Sections, each item with evidence, `file:line`, and suggested action:

- Remove: objectively unneeded (fully covered by something else, or cannot work at all); never "no usage found"
- Fix: wanted but broken (stale path, missing cache)
- Duplicate: two enabled items doing the same job
- Stale: used, but upstream archived or long inactive
- Watch: no or little usage evidence; ask the user whether they use it

End with a one-line count of fine items (per config entry) and ask which items to act on.

## Applying Approved Changes

- Neovim: comment out the spec with a `-- -> <replacement or reason>` line; keep `pluginconfig/*` files. If it replaced a plugin feature (e.g. a keymap), reimplement it before removal.
- zsh: comment out the `zinit` entry with a `# <reason>` line; keep pluginconfig files.
- mise: delete the `[tools]` line; also update `zsh-completions-sync`, `.gitignore` exceptions and shell references.
- Tell the user about leftovers: `:Lazy clean`, `mise prune`, new shell for zsh.
- Verify: headless Neovim (`:messages` empty, plugin not in `package.loaded`), `zsh -n`, then `./.mise/tasks/lint` (`mise run lint` fails in the sandbox on tool auto-install).

## Common Mistakes

| Mistake                                            | Instead                                                                     |
| -------------------------------------------------- | --------------------------------------------------------------------------- |
| Claiming a built-in replacement from memory        | Quote the local `:help` text                                                |
| "Not updated since 2024" ⇒ remove                  | Only remove if broken or fully duplicated                                   |
| "Not in shell history" ⇒ Remove                    | Check per-directory history and non-shell launchers; then ask (Watch)       |
| Reading a skipped `curl` as a dead URL             | Sandbox may deny it; use `gh api … -H "Accept: application/vnd.github.raw"` |
| Editing files during the audit                     | Report first, edit after the user chooses                                   |
| "No source in `mise ls`" ⇒ `mise prune` removes it | Check tracked configs; prune keeps tools other projects reference           |
