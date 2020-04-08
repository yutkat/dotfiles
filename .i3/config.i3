
###################
## i3 Optional Key Bind
###################

# reload the configuration file
bindsym $mod+Control+Shift+r exec "~/.i3/scripts/mkconfig.sh && i3-msg reload"
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r exec "~/.i3/scripts/mkconfig.sh && i3-msg restart"

# display
bindsym XF86Display exec "~/.i3/scripts/detect_displays.sh"


###################
## i3 Application Key Bind
###################

# quick window selector like easymotion
bindsym $mod+Tab exec "i3-easyfocus --all -f '*Mono*' --color-unfocused-fg 9ec400"


###################
# i3 Startup
###################

# wallpaper
exec --no-startup-id "feh --randomize --bg-scale ~/.wallpaper/*"

