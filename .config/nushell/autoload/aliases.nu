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

## application ##
alias vi = snvim
def --wrapped snvim-net [...args] { with-env {SNVIM_NET: "1"} { ^snvim ...$args } }
def --wrapped snvim-offline [...args] { with-env {SNVIM_NET: "none"} { ^snvim ...$args } }
def --wrapped snvim-wall [...args] { with-env {SNVIM_NET: "wall"} { ^snvim ...$args } }
alias v = nvim -c "PossessionLoadCurrent"
alias sv = ^sudo nvim
alias hx = helix
alias gi = aicommits

## git (fallback for the abbreviations in abbr.nu) ##
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

# Counterpart of zsh-pbcopy's pbcopy (a zsh function nu cannot call); falls back to OSC 52 without a clipboard tool.
def pbcopy [] {
  let input = ($in | into string)
  if ($env.WAYLAND_DISPLAY? | is-not-empty) and (which wl-copy | is-not-empty) {
    $input | ^wl-copy
  } else if ($env.DISPLAY? | is-not-empty) and (which xsel | is-not-empty) {
    $input | ^xsel -i --primary
    $input | ^xsel -i --clipboard
  } else if ($env.DISPLAY? | is-not-empty) and (which xclip | is-not-empty) {
    $input | ^xclip -i -selection primary
    $input | ^xclip -i -selection clipboard
  } else {
    use std/clip
    $input | clip copy52
  }
}

# xauth
def xauth-copy [] {
  ^xauth list | lines | last | split row -r '\s+' | get 2 | pbcopy
}

# udev
def reload-udev-hwdb [] {
  ^sudo systemd-hwdb update
  ^sudo udevadm trigger
}

## App ##
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

alias xterm-modifyOtherKyes = ^xterm -xrm "*modifyOtherKeys:1"

## AI agents ##
# Shared wrapper in .local/bin/agent-run
def --wrapped claude [...args] { ^agent-run claude ...$args }
def --wrapped codex [...args] { ^agent-run codex ...$args }

alias c = claude
alias cr = claude --resume
alias cn = claude --continue
alias x = codex
alias xr = codex resume

## ArchLinux ##
const arch_aliases = if ("/etc/arch-release" | path exists) { path self ../arch-aliases.nu } else { null }
source $arch_aliases
