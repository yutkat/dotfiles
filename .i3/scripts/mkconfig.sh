#!/bin/sh

print_term() {
echo '# start a terminal'
if type lilyterm > /dev/null 2>&1;then
cat << 'EOS'
bindsym $mod+Return exec lilyterm -u ~/.lilyterm/default.conf
EOS
else
cat << 'EOS'
bindsym $mod+Return exec i3-sensible-terminal
EOS
fi
echo ''
}


print_bar() {
echo '# Start i3bar to display a workspace bar (plus the system information i3status'
echo '# finds out, if available)'
echo 'bar {'
if type i3blocks > /dev/null 2>&1;then
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
elif type i3status > /dev/null 2>&1;then
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

cat ~/.i3/config.base > ~/.i3/config
print_term >> ~/.i3/config
print_bar >> ~/.i3/config
chmod 444 ~/.i3/config

