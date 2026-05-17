hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,
    border_size = 2,
    col = {
      active_border = "0x66ee1111",
      inactive_border = "0x66333333",
    },
  },

  input = {
    kb_layout = "",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 1,
    repeat_rate = 50,
    repeat_delay = 500,
    scroll_factor = 1.5,
    touchpad = {
      natural_scroll = false,
    },
  },

  cursor = {
    inactive_timeout = 5,
  },

  decoration = {
    rounding = 10,
    blur = {
      size = 3,
      passes = 1,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    force_split = 2,
    preserve_split = true,
  },

  opengl = {
    nvidia_anti_flicker = false,
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },

  debug = {
    disable_logs = false,
  },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })
