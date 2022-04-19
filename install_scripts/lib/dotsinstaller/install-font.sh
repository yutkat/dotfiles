#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

# myrica
# sudo mkdir -p /usr/share/fonts/myrica
# sudo curl -L https://github.com/tomokuni/Myrica/raw/master/product/MyricaM.zip -o /tmp/MyricaM.zip
# (cd /tmp && sudo unzip -o MyricaM.zip -d /usr/share/fonts/myrica)

mkdir -p ~/.local/share/fonts

# udev gothic
mkdir -p ~/.local/share/fonts/UDEVGothic
UDEV_GOTHIC_RELEASES_URL="https://api.github.com/repos/yuru7/udev-gothic/releases"
curl -sfL "${UDEV_GOTHIC_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep _NF_ | xargs -I{} curl -fL -o /tmp/UDEVGothic.zip "{}"
(cd /tmp && unzip -j -o UDEVGothic.zip -d ~/.local/share/fonts/UDEVGothic)

# cica
mkdir -p ~/.local/share/fonts/cica
CICA_RELEASES_URL="https://api.github.com/repos/miiton/Cica/releases"
curl -sfL "${CICA_RELEASES_URL}" | jq -r '.[0].assets | .[].browser_download_url' | grep -i without_emoji.zip | xargs -I{} curl -fL -o /tmp/Cica.zip "{}"
(cd /tmp && unzip -o Cica.zip -d ~/.local/share/fonts/cica)

fc-cache -vf
