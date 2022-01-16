local wezterm = require 'wezterm';

return {
  font = wezterm.font("Cica"),
  use_ime = true,
  font_size = 10.0,
  color_scheme = "nordfox",
  color_scheme_dirs = {"/home/kata/.config/wezterm/colors/"},
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = true,
  keys = {
    {key = "c", mods = "CTRL|SHIFT", action = wezterm.action {CopyTo = "Clipboard"}},
    {key = "v", mods = "CTRL|SHIFT", action = wezterm.action {PasteFrom = "Clipboard"}},
    {key = "Insert", mods = "SHIFT", action = wezterm.action {PasteFrom = "PrimarySelection"}},
    {key = "=", mods = "CTRL", action = "ResetFontSize"},
    {key = "+", mods = "CTRL", action = "IncreaseFontSize"},
    {key = "-", mods = "CTRL", action = "DecreaseFontSize"}
  }
}
