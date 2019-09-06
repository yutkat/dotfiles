#!/bin/bash

if [ ! -e /usr/local/bin/set_xmodmap.sh ]; then
  sudo tee /usr/local/bin/set_xmodmap.sh << "EOF" > /dev/null
#!/bin/bash
sleep 1

DISPLAY=":0"
HOME=/home/kata
XAUTHORITY=$HOME/.Xauthority
export DISPLAY HOME XAUTHORITY

setxkbmap
xmodmap $HOME/.Xmodmap
EOF
  sudo chmod +x /usr/local/bin/set_xmodmap.sh
fi

if [ ! -e /usr/local/bin/auto_xmodmap.sh ]; then
  sudo tee /usr/local/bin/auto_xmodmap.sh << "EOF" > /dev/null
#!/bin/bash

nohup /usr/local/bin/set_xmodmap.sh >/dev/null 2>&1 &
EOF
  sudo chmod +x /usr/local/bin/auto_xmodmap.sh
fi

line='SUBSYSTEM==\"input\", KERNEL==\"input*\", ATTRS{phys}==\"usb*input*\", ATTRS{name}==\"*HHKB*\", ACTION==\"add\|remove\", RUN+=\"/usr/local/bin/auto_xmodmap.sh\"'
sudo bash -c "echo $line > /etc/udev/rules.d/99-keyboard-hotplug.rules"

sudo udevadm control --reload-rules;

