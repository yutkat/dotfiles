#!/bin/bash

sudo ln -snf $HOME/.i3/scripts/detect_displays.sh /usr/local/bin/detect_displays.sh
line='SUBSYSTEM==\"drm\", ACTION==\"change\", RUN+=\"/usr/local/bin/detect_displays.sh\"'
sudo bash -c "echo $line > /etc/udev/rules.d/95-monitor-hotplug.rules"

