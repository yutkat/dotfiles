#!/bin/bash

isContinue(){
    if [[ "$?" -ne 0 ]];then
        echo "Install Failed"
        exit 1
    fi
}

sudo apt-get install aptitude python-keyring python-statgrab ttf-ubuntu-font-family hddtemp curl lm-sensors conky-all
sudo chmod u+s /usr/sbin/hddtemp
wget http://fc00.deviantart.net/fs71/f/2013/290/5/b/conky_colors_by_helmuthdu-d41qrmk.zip -O /tmp/conky_colors.zip && unzip /tmp/conky_colors.zip
isContinue
(cd /tmp/conky_colors; make; sudo make install)
isContinue
sudo fc-cache -v -f

echo "Install Success"

