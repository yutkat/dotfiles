#!/bin/sh

print_bar() {
cat << 'EOS'
# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    bindsym button4 nop
    bindsym button5 nop
EOS
if builtin command -v i3blocks > /dev/null 2>&1;then
cat << 'EOS'
    status_command i3blocks -c ~/.i3/i3blocks.conf
    tray_output primary
    colors {
        # background #000000
        # separator  #666666
        # statusline #ffffff
        #
        # focused_workspace  #44bbff #3276E8 #ffffff
        # active_workspace   #333333 #5f676a #ffffff
        # inactive_workspace #333333 #222222 #888888
        # urgent_workspace   #2f343a #900000 #ffffff
        background $bg-color
        separator #757575
        #                  border             background         text
        focused_workspace  $bg-color          $bg-color          $text-color
        inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
        urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
    }
EOS
elif builtin command -v i3status > /dev/null 2>&1;then
cat << 'EOS'
    status_command i3status -c ~/.i3/i3status.conf
    workspace_buttons yes
EOS
else
cat << 'EOS'
    status_command i3status
    tray_output primary
EOS
fi
cat << 'EOS'
}

EOS
}


cd $(dirname $0)

I3_CONFIG="$HOME/.i3/config"

[ -e $I3_CONFIG ] && rm -f $I3_CONFIG
cat ~/.i3/config.base > $I3_CONFIG

if builtin command -v "i3-msg" > /dev/null 2>&1; then
  if [ $(i3-msg aaa 2>&1 | \grep gaps | wc -l) -ne 0 ]; then
    cat ~/.i3/config.gaps  >> $I3_CONFIG
  fi
fi

if [ -f "$HOME/.i3/config.local" ]; then
  cat "$HOME/.i3/config.local" >> $I3_CONFIG
fi

print_bar >> $I3_CONFIG

chmod 444 $I3_CONFIG

