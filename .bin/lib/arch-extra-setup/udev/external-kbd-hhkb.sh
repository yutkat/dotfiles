#!/usr/bin/env bash
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")

if [ ! -e /usr/local/bin/set_xmodmap.sh ]; then
  sudo tee /usr/local/bin/set_xmodmap.sh << "EOF" > /dev/null
#!/usr/bin/env bash
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
#!/usr/bin/env bash

nohup /usr/local/bin/set_xmodmap.sh >/dev/null 2>&1 &
EOF
  sudo chmod +x /usr/local/bin/auto_xmodmap.sh
fi

sudo cp $CURRENT_DIR/rules.d/99-keyboard-hotplug.rules /etc/udev/rules.d/

sudo udevadm control --reload-rules;

