# Counterpart of `direnv hook zsh` (preload_command_config.zsh): load .envrc on every prompt,
# e.g. ~/Workspace/.envrc switches the gh account via GH_CONFIG_DIR.
$env.config.hooks.pre_prompt = (
  $env.config.hooks.pre_prompt? | default [] | append {||
    if (which direnv | is-empty) { return }
    direnv export json | from json | default {} | load-env
    # direnv exports PATH as a string; Nushell needs a list.
    if ($env.PATH | describe) == "string" {
      $env.PATH = ($env.PATH | split row (char esep))
    }
  }
)
