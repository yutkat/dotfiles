#!/usr/bin/env sh
case "$1" in
  lock)
    if builtin command -v betterlockscreen > /dev/null 2>&1; then
      if [ ! -e ~/.cache/multilock ]; then
        betterlockscreen -u ~/.config/i3/wallpaper/
      fi
      betterlockscreen --lock
      exit 0
    fi

    version=$(i3lock --version 2>&1 | awk '{print $3}')
    if echo $version | grep -c 'c'; then
      # B='#00000000' # blank
      # C='#ffffff22' # clear ish
      # D='#ff00ffcc' # default
      # T='#ee00eeee' # text
      # W='#880000bb' # wrong
      # V='#bb00bbbb' # verifying
      B='#00000000' # blank
      C='#ffffff22' # clear ish
      D='#4c7899ff' # default
      T='#285577ff' # text
      W='#E53935ff' # wrong
      V='#3276E8ff' # verifying
      i3lock --insidevercolor=$C --ringvercolor=$V --insidewrongcolor=$C --ringwrongcolor=$W --insidecolor=$B --ringcolor=$D --linecolor=$B --separatorcolor=$D --verifcolor=$T --wrongcolor=$T --timecolor=$T --datecolor=$T --layoutcolor=$T --keyhlcolor=$W --bshlcolor=$W --blur 15 --clock --indicator --timestr="%H:%M:%S" --datestr="%Y-%m-%d (%a)"
    else
      i3lock -c 282C34 -n &
    fi
    # sleep 20 && pgrep i3lock && xset dpms force off
    ;;
  logout)
    i3-msg exit
    ;;
  suspend)
    systemctl suspend
    ;;
  hibernate)
    systemctl hibernate
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
    exit 2
    ;;
esac

exit 0
