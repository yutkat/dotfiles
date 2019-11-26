#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

# myrica
# sudo mkdir -p /usr/share/fonts/myrica
# sudo curl -L https://github.com/tomokuni/Myrica/raw/master/product/MyricaM.zip -o /tmp/MyricaM.zip
# (cd /tmp && sudo unzip -o MyricaM.zip -d /usr/share/fonts/myrica)

# cica
sudo mkdir -p /usr/share/fonts/cica
CICA_RELEASES_URL="https://api.github.com/repos/miiton/Cica/releases"
sudo curl -sfL "${CICA_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep with_emoji.zip | xargs -I{} curl -fL -o /tmp/Cica.zip "{}"
(cd /tmp && sudo unzip -o Cica.zip -d /usr/share/fonts/cica)

if [ ! -d $HOME/.config/fontconfig ]; then
  mkdir -p $HOME/.config/fontconfig
  cat > $HOME/.config/fontconfig/fonts.conf << "EOF"
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<alias>
		<family>monospace</family>
		<prefer>
			<family>Cica</family>
		</prefer>
	</alias>
</fontconfig>
EOF
fi

sudo fc-cache -vf

