local lang = os.getenv("LANG") or ""
local home = os.getenv("HOME") or ""

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("GTK_THEME", "Arc-Dark")
hl.env("QT_STYLE_OVERRIDE", "kvantum-dark")
hl.env("LC_CTYPE", lang)
hl.env("LC_NUMERIC", lang)
hl.env("LC_TIME", lang)
hl.env("LC_COLLATE", lang)
hl.env("LC_MONETARY", lang)
hl.env("LC_MESSAGES", lang)
hl.env("LC_PAPER", lang)
hl.env("LC_NAME", lang)
hl.env("LC_ADDRESS", lang)
hl.env("LC_TELEPHONE", lang)
hl.env("LC_MEASUREMENT", lang)
hl.env("LC_IDENTIFICATION", lang)
hl.env("LC_ALL", "")

hl.env("HYPRCURSOR_THEME", "Nordzy-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "ComixCursors-Black")
hl.env("XCURSOR_SIZE", "24")

hl.env("QT_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULES", "wayland;fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("FCITX_DATA_HOME", home .. "/.config/fcitx5/data")
