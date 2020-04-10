#!/usr/bin/env bash

ROOT_DIR=$(cd $(dirname $0)/..; pwd)
CONFIG="$ROOT_DIR/config"

[ -e "$CONFIG" ] && rm -f $CONFIG
cat "$ROOT_DIR/config.base" > $CONFIG

shopt -s extglob
if ls $ROOT_DIR/config.!(base*) > /dev/null 2>&1; then
  cat $ROOT_DIR/config.!(base*)  >> $CONFIG
fi

chmod 444 $CONFIG

