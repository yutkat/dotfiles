cache = true
std = luajit
codes = true
self = false

exclude_files = {
  "install_scripts/lib/dotsinstaller/fcitx5/escape_pass_through.lua"
}
ignore = {
  "211", "212", "213", "311", "631"
}

globals = {
  "vim",
  "globals",
  "downloads",
}
