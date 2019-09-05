#!/bin/bash

if [ ! -e /usr/local/bin/auto_xmodmap.sh ]; then
  sudo tee /usr/local/bin/auto_xmodmap.sh << "EOF" > /dev/null
#!/bin/bash
sleep 2

DISPLAY=":0"
HOME=/home/kata
XAUTHORITY=$HOME/.Xauthority
export DISPLAY HOME XAUTHORITY

setxkbmap
nohup xmodmap $HOME/.Xmodmap
EOF
  sudo chmod +x /usr/local/bin/auto_xmodmap.sh
fi

line='SUBSYSTEM==\"input\", ACTION==\"add\|remove\", RUN+=\"/usr/local/bin/auto_xmodmap.sh\"'
sudo bash -c "echo $line > /etc/udev/rules.d/99-keyboard-hotplug.rules"



