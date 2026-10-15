# Prompt with git status; one `git status` call per prompt, no external prompt binary.
def prompt-git [] {
  let r = (^git --no-optional-locks status --porcelain=v2 --branch | complete)
  if $r.exit_code != 0 { return "" }
  let lines = ($r.stdout | lines)
  let header = ($lines | where ($it | str starts-with "# ") | parse "# branch.{key} {value}" | transpose -r -d)
  let branch = if ($header.head? | default "(detached)") == "(detached)" {
    $header.oid? | default "" | str substring 0..6
  } else { $header.head }
  let ab = ($header.ab? | default "+0 -0" | parse "+{a} -{b}" | first)
  let entries = ($lines | where not ($it | str starts-with "# "))
  let xy = ($entries | where ($it =~ '^[12] ') | each { str substring 2..3 })
  let staged = ($xy | where ($it | str substring 0..0) != "." | length)
  let modified = ($xy | where ($it | str substring 1..1) != "." | length)
  let conflicted = ($entries | where ($it | str starts-with "u ") | length)
  let untracked = ($entries | where ($it | str starts-with "? ") | length)

  let parts = [
    [($ab.a | into int) $"(ansi cyan)⇡($ab.a)"]
    [($ab.b | into int) $"(ansi cyan)⇣($ab.b)"]
    [$conflicted $"(ansi red)=($conflicted)"]
    [$staged $"(ansi green)+($staged)"]
    [$modified $"(ansi yellow)!($modified)"]
    [$untracked $"(ansi blue)?($untracked)"]
  ] | where { |p| $p.0 > 0 } | each { |p| $p.1 }

  let dirty = if ($parts | is-empty) { "" } else { " " + ($parts | str join " ") }
  $" (ansi magenta) ($branch)($dirty)(ansi reset)"
}

def prompt-dir [] {
  let home = $nu.home-dir
  let dir = if ($env.PWD | str starts-with $home) {
    $env.PWD | str replace $home "~"
  } else { $env.PWD }
  $"(ansi blue_bold)($dir)(ansi reset)"
}

$env.PROMPT_COMMAND = {|| $"(prompt-dir)(prompt-git)" }
$env.PROMPT_COMMAND_RIGHT = {||
  let code = $env.LAST_EXIT_CODE
  let ms = ($env.CMD_DURATION_MS? | default "0" | into int)
  let took = if $ms >= 2000 { $"(ansi yellow)($ms * 1ms | format duration sec) " } else { "" }
  let status = if $code != 0 { $"(ansi red)✘ ($code)" } else { "" }
  $"($took)($status)(ansi reset)"
}
$env.PROMPT_INDICATOR = {|| $"\n(ansi green_bold)❯(ansi reset) " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| $"\n(ansi green_bold)❯(ansi reset) " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"\n(ansi magenta_bold)❮(ansi reset) " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "∙ " }
