# Counterparts of .config/zsh/rc/alias.zsh that fit Nushell.
# Not ported: global/suffix aliases, zsh-only helpers, and numeric names (644 etc.), which Nushell rejects.

## common ##
alias cp = cp -irf
alias mv = mv -i
alias sc = screen
alias l = less
def --wrapped less-plain [...args] {
  with-env {LESS: ""} { ^less ...$args }
}
alias sudo = ^sudo -H
alias cl = clear
alias quit = exit
alias rez = exec nu
alias arch = ^uname -m

# cd to the git repository root
def --env cdr [] {
  cd (^git rev-parse --show-toplevel)
}

def --wrapped makej [...args] {
  ^make -j (sys cpu | length) ...$args
}

# ls (Nushell's structured ls)
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias lal = ls -la
def "l." [] {
  ls -a | where name =~ '^\.[a-zA-Z]'
}

# grep display filename, display line count, do not process binary files
alias gre = ^grep -H -n -I --color=auto

def extract [...files: path] {
  for f in $files {
    # Legacy formats are not supported by ouch.
    if ($f | str ends-with ".lzh") {
      ^lha e $f
    } else if ($f | str ends-with ".tar.Z") {
      ^tar zxvf $f
    } else if ($f | str ends-with ".Z") {
      ^uncompress $f
    } else if ($f | str ends-with ".arj") {
      ^unarj $f
    } else {
      ^ouch decompress --here $f
    }
  }
}

## application ##
alias vi = nvim
alias v = nvim -c "PossessionLoadCurrent"
alias sv = ^sudo nvim
alias hx = helix
alias gi = aicommits

## git (abbreviations in .config/zsh/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh) ##
alias gc = git commit
alias ga = git add .
alias gb = git branch
alias gd = git diff HEAD
alias gs = git status --short
alias gr = gh renew
def pr [] {
  try { ^gh pr view -w } catch { ^gh pr create -w }
}

## development ##
alias py = python
alias gdb = ^gdb -silent -nh -x ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "gdb/init")

# man
alias man-ascii-color-code = ^man 4 console_codes

# tmux
alias tmux = ^tmux -2
alias t = ^tmux -2
alias ta = ^tmux -2 attach -d

# xauth
def xauth-copy [] {
  ^xauth list | lines | last | split row -r '\s+' | get 2 | ^pbcopy
}

# udev
def reload-udev-hwdb [] {
  ^sudo systemd-hwdb update
  ^sudo udevadm trigger
}

## App ##
def Xresources-reload [] {
  ^xrdb -remove
  ^xrdb $"-DHOME_ENV=\"($env.HOME)\"" -merge ($env.HOME | path join ".config/X11/Xresources")
}
alias web-server = ^python -m SimpleHTTPServer 8000
alias generate-passowrd = ^openssl rand -base64 20
def --wrapped mount-myself [...args] {
  ^sudo mount -o $"uid=(^id -u),gid=(^id -g)" ...$args
}
alias xhost-local = ^xhost local:
# luajit patch https://github.com/LuaJIT/LuaJIT/issues/369
alias luajit = ^rlwrap luajit

def --wrapped docker [...args] {
  if (which podman | is-not-empty) { ^podman ...$args } else { ^docker ...$args }
}

alias hdu = ^ncdu --color dark -rr -x --exclude .git --exclude node_modules
alias disk-usage = ^sudo ncdu --color dark -rr --exclude .git --exclude node_modules --exclude .snapshots /

def screencast [] {
  let geometry = (^slurp)
  ^wf-recorder -g $geometry -f ($env.HOME | path join $"Pictures/wf_(date now | format date '%y%m%d-%H%M%S').mp4")
}
alias xterm-modifyOtherKyes = ^xterm -xrm "*modifyOtherKeys:1"

## AI agents ##
# Run an agent TUI, then restore the pane tint and clear like Ctrl-L unless it was a one-shot run.
# `args` are the arguments the user typed; `cmd_args` may add wrapper defaults.
def --env run-agent [cmd: string, cmd_args: list<string>, args: list<string>, one_shot: list<string>] {
  let code = try { ^$cmd ...$cmd_args; 0 } catch {|e| $e.exit_code? | default 1 }
  try { "\e]111\a" | save --append /dev/tty }
  if (is-terminal --stdout) {
    mut clear = true
    for arg in $args {
      if $arg in $one_shot {
        $clear = false
        break
      }
      if not ($arg | str starts-with "-") { break }
    }
    if $clear { print -n "\e[H\e[2J" }
  }
  $env.LAST_EXIT_CODE = $code
}

def --env --wrapped claude [...args] {
  run-agent claude $args $args [
    -p --print -h --help -v --version auth auto-mode doctor gateway import install logs mcp plugin plugins
    project respawn rm setup-token stop kill ultrareview update upgrade
  ]
}

def --env --wrapped codex [...args] {
  # Profiles require embedded mode; request it explicitly to avoid a fallback warning.
  let daemon_args = if "--no-daemon" in $args { [] } else { [--no-daemon] }
  let has_profile = ($args | any {|a| $a in [-p --profile] or ($a | str starts-with "--profile=") })
  # The last matching subcommand decides, as in the zsh wrapper.
  let use_local = ($args | reduce --fold true {|a, acc|
    if $a == "prompt-input" {
      true
    } else if $a in [
      login logout plugin mcp-server app-server remote-control completion update doctor features help apply cloud
      exec-server debug
    ] {
      false
    } else { $acc }
  })
  let full_args = if $has_profile {
    [...$daemon_args ...$args]
  } else if $use_local {
    [...$daemon_args --profile local ...$args]
  } else { $args }

  # Tint the pane while Codex runs.
  try { "\e]11;#2d3838\a" | save --append /dev/tty }
  run-agent codex $full_args $args [
    -h --help -V --version exec e review login logout mcp plugin app-server remote-control completion update doctor
    sandbox debug apply a queue archive delete migrate-rollouts unarchive exec-server features help
  ]
}

alias c = claude
alias cr = claude --resume
alias cn = claude --continue
alias x = codex
alias xr = codex resume

## ArchLinux ##
const arch_aliases = if ("/etc/arch-release" | path exists) { path self ../arch-aliases.nu } else { null }
source $arch_aliases
