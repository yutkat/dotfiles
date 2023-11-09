#!/bin/bash

if [[ ! "$DUNST_BODY" =~ \.(xlsx|csv)$ ]]; then
    exit
fi


FILE=$(echo "$DUNST_BODY" | tail -n 1)
ACTION=$(notify-send --replace-id="$DUNST_ID" -a LibreOffice "$FILE" --action="libreoffice" --icon=/usr/share/icons/hicolor/64x64/apps/libreoffice-calc.png)

case "$ACTION" in
"0")
    libreoffice --calc "$HOME/Downloads/$FILE"
    ;;
"2")
    ;;
esac
