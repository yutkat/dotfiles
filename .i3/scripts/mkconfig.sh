#!/bin/sh

print_bar() {
echo '# Start i3bar to display a workspace bar (plus the system information i3status'
echo '# finds out, if available)'
echo 'bar {'
if builtin command -v i3blocks > /dev/null 2>&1;then
cat << 'EOS'
        status_command i3blocks -c ~/.i3/i3blocks.conf
        tray_output primary
        colors {
                background #000000
                separator  #666666
                statusline #ffffff

                focused_workspace  #44bbff #3276E8 #ffffff
                active_workspace   #333333 #5f676a #ffffff
                inactive_workspace #333333 #222222 #888888
                urgent_workspace   #2f343a #900000 #ffffff
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
echo '}'
echo ''
}


cd $(dirname $0)

I3_CONFIG="$HOME/.i3/config"

[ -e $I3_CONFIG ] && rm -f $I3_CONFIG
cat ~/.i3/config.base > $I3_CONFIG

 if [ $(i3-msg aaa |& \grep gaps | wc -l) -ne 0 ]; then
  cat ~/.i3/config.gaps  >> $I3_CONFIG
fi

print_bar >> $I3_CONFIG

chmod 444 $I3_CONFIG

