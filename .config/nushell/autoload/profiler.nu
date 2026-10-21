# Counterparts of zsh-startuptime / zsh-startuptime-slower-than-default in function.zsh.
# `-e exit` loads config.nu and autoload like an interactive start; `-c` would skip them.

def to-ms []: duration -> int {
  $in / 1ms | math round
}

# Time an interactive nu startup `runs` times and print the average.
def nu-startuptime [runs: int = 10] {
  let times = 1..$runs | each {|i|
    let t = timeit { ^nu -e exit | ignore }
    print $"($i | fill -a r -w 2): ($t | to-ms)"
    $t
  }
  print $"\naverage: ($times | math avg | to-ms) [ms]"
}

# Compare the startup time with and without the config files.
def nu-startuptime-slower-than-default [runs: int = 5] {
  let mine = 1..$runs | each { timeit { ^nu -e exit | ignore } } | math avg
  let default = 1..$runs | each { timeit { ^nu --no-config-file -e exit | ignore } } | math avg
  print $"my config: ($mine | to-ms)ms\ndefault nu: ($default | to-ms)ms\n"
  print $"($mine / $default | math round -p 2)x slower your nu than the default."
}
