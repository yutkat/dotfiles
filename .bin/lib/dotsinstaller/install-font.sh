#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

sudo mkdir -p /usr/share/fonts/myrica
sudo curl -L https://github.com/tomokuni/Myrica/raw/master/product/MyricaM.TTC -o /usr/share/fonts/myrica/MyricaM.TTC

mkdir -p $XDG_CONFIG_HOME/fontconfig
cat > $XDG_CONFIG_HOME/fontconfig/fonts.conf << "EOF"
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<alias>
		<family>monospace</family>
		<prefer>
			<family>MyricaM M</family>
		</prefer>
	</alias>
</fontconfig>
EOF

sudo fc-cache -vf

