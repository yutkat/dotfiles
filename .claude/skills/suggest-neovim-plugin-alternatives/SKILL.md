---
name: suggest-neovim-plugin-alternatives
description: >
  Analyze Neovim plugins and suggest modern alternatives. Activate when user
  asks about plugin alternatives, plugin migration, outdated plugins,
  unmaintained plugins, modernizing neovim config, plugin recommendations,
  checking plugins, updating plugin list, plugin audit, neovim plugin review, or
  better plugin suggestions.
version: 1.0.0
---

# Neovim Plugin Migration Suggestion Skill

You are a Neovim plugin expert. Your task is to analyze the user's current Neovim plugins and suggest modern alternatives using the reference plugin list at <https://github.com/yutkat/my-neovim-pluginlist>.

> **Note**: This skill requires [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. It will not work with other plugin managers.

## Execution Phases

### Phase 1: Get Current Plugins

Run the following command to get the list of currently installed plugins:

```bash
nvim --headless -c 'lua vim.defer_fn(function()
  for _, plugin in ipairs(require("lazy").plugins()) do
    io.write(plugin.url .. "\n")
  end
  vim.cmd("qall")
end, 100)'
```

This outputs one GitHub URL per line (e.g., `https://github.com/folke/lazy.nvim.git`) for every plugin managed by lazy.nvim. Parse the output to extract `owner/repo` slugs.

### Phase 2: Determine Scope

Based on the user's request, choose one of three modes:

- **Full audit**: User asks about all plugins (e.g., "check all my plugins", "audit my neovim plugins"). Scan all active plugins, fetch the 8-10 most impactful category files first.
- **Category-specific**: User asks about a specific category (e.g., "check my LSP plugins"). Focus on that category, fetch only the relevant category file(s).
- **Single plugin**: User asks about a specific plugin (e.g., "is there a better alternative to nvim-spectre?"). Fetch only the relevant category file and provide a detailed comparison.

### Phase 3: Fetch Category Index (SECTION.md)

First, fetch the category index file to understand the full structure of the reference plugin list:

```
https://raw.githubusercontent.com/yutkat/my-neovim-pluginlist/main/.codex/skills/add/references/SECTION.md
```

This file contains the complete hierarchy of all category files and their sections. The format is:

```markdown
# filename.md

## Top-level section

### Subsection

#### Sub-subsection
```

Each `# filename.md` heading corresponds to a category file in the repository root. Use this index to:

1. Map each plugin from `pluginlist.lua` to the appropriate category file by matching the plugin's section header or functionality against the SECTION.md hierarchy
2. Identify which category files need to be fetched for the current scope

### Phase 4: Fetch Category Files

For each relevant category identified from SECTION.md, fetch the corresponding markdown file:

```
https://raw.githubusercontent.com/yutkat/my-neovim-pluginlist/main/{filename}
```

Parse the fetched markdown to extract:

- Plugin name and GitHub URL (format: `[plugin-name](https://github.com/owner/repo)`)
- Subcategory headings for context
- Any descriptive text about the plugin

**Important**: Do NOT try to parse shields.io badge URLs for star counts or activity data. These are image references that only render in a browser.

**Scope control**:

- For a full audit, fetch the 8-10 most impactful category files first (e.g., completion.md, lsp.md, fuzzy-finder.md, treesitter.md, git-github.md, comment.md, search_replace_grep_select.md, test.md)
- For category-specific requests, fetch only the relevant category file(s)
- For single plugin requests, fetch only the one relevant category file

### Phase 5: Health Check via GitHub API

For plugins where a migration might be warranted (suspected issues, known alternatives, or low activity), check their health using the `gh` CLI:

```bash
gh api repos/{owner}/{repo} --jq '{stars: .stargazers_count, archived: .archived, pushed_at: .pushed_at, description: .description}'
```

Do the same for their potential alternatives to enable comparison.

**Constraints**:

- Only check health for plugins where there is a suspected issue or a known alternative
- Limit to ~20 API calls per invocation to avoid rate limiting
- Prioritize the most critical/impactful plugins first

### Phase 6: Generate Report

Output a structured markdown report organized into these sections:

#### 1. Urgent Migrations

Plugins that are archived, deprecated, or using outdated versions.

#### 2. Recommended Upgrades

Active plugins that have a clearly better or more modern alternative.

#### 3. Consider Reviewing

Plugins that are less active but still functional; alternatives exist but migration is not urgent.

#### 4. Up to Date

Plugins that are already the best or among the best in their category (brief summary only).

**Table format for sections 1-3**:

| Current Plugin | Category | Status                | Suggested Alternative(s) | Reason      |
| -------------- | -------- | --------------------- | ------------------------ | ----------- |
| plugin-name    | Category | Active/Stale/Archived | alternative-name (stars) | Why migrate |

## Well-Known Migration Paths

These are established community migration paths. Check these first before doing expensive lookups:

| Current                    | Suggested Alternative                                          | Notes                                                                                                               |
| -------------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `fidget.nvim` (tag=legacy) | `fidget.nvim` (main branch, v2)                                | Remove `tag = "legacy"` to use the rewritten version                                                                |
| `popup.nvim`               | Remove (redundant)                                             | `nui.nvim` is already installed and provides all needed functionality. Neovim built-in `vim.ui` also covers basics. |
| `Comment.nvim`             | Built-in `gc`/`gcc` (Neovim 0.10+) or `ts-comments.nvim`       | Neovim now has native commenting support                                                                            |
| `nvim-spectre`             | `grug-far.nvim`                                                | More actively maintained with better UX                                                                             |
| `nvim-web-devicons`        | `mini.icons`                                                   | Lighter, faster, part of mini.nvim ecosystem                                                                        |
| `nvim-test`                | `neotest`                                                      | De facto standard for testing in Neovim                                                                             |
| `ChatGPT.nvim`             | `CopilotChat.nvim` (already installed) or `codecompanion.nvim` | ChatGPT.nvim requires separate API key; CopilotChat is already in the config                                        |
| `telescope.nvim`           | `snacks.nvim` picker or `fzf-lua`                              | Growing trend; snacks.nvim is already installed. Consider for future migration.                                     |
| `plenary.nvim`             | Neovim built-ins (`vim.uv`, `vim.system`, etc.)                | Being gradually replaced; still needed by some plugins as dependency                                                |
| `nvim-cmp`                 | `blink.cmp`                                                    | Already migrated in this config                                                                                     |
| `null-ls.nvim`             | `conform.nvim` + `nvim-lint`                                   | Already migrated in this config                                                                                     |
| `packer.nvim`              | `lazy.nvim`                                                    | Already migrated in this config                                                                                     |
| `neodev.nvim`              | `lazydev.nvim`                                                 | Already migrated in this config                                                                                     |
| `nvim-surround`            | `mini.surround`                                                | Already migrated in this config                                                                                     |

## Output Language

Respond in the same language as the user's request. If the user asks in Japanese, respond in Japanese.
