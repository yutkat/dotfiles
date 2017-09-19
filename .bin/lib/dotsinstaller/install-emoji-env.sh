#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh


curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o $HOME/.bin/emojify && chmod +x $HOME/.bin/emojify

checkinstall jq
