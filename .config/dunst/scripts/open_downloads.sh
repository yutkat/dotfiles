#!/bin/bash

FILE=$(echo "$DUNST_BODY" | tail -n 1)

# Vivaldi elides long filenames in the notification body (e.g. "name….csv"),
# so map the elided name back to the real file by glob matching.
resolve_file() {
	local IFS= name=$1 glob f newest=
	if [[ -e "$HOME/Downloads/$name" ]]; then
		printf '%s' "$name"
		return
	fi
	glob=${name//…/*}
	glob=${glob//'...'/*}
	if [[ "$glob" == "$name" ]]; then
		printf '%s' "$name"
		return
	fi
	for f in "$HOME/Downloads"/$glob; do
		if [[ -e "$f" && (-z "$newest" || "$f" -nt "$newest") ]]; then
			newest=$f
		fi
	done
	if [[ -n "$newest" ]]; then
		printf '%s' "${newest##*/}"
	else
		printf '%s' "$name"
	fi
}

FILE=$(resolve_file "$FILE")

# Handle PDF and image files with Vivaldi
if [[ "$FILE" =~ \.(pdf|png|jpe?g)$ ]]; then
	ACTION=$(notify-send --replace-id="$DUNST_ID" -a Vivaldi "$FILE" --action="vivaldi" --icon=/usr/share/pixmaps/vivaldi.png)

	case "$ACTION" in
	"0")
		vivaldi "$HOME/Downloads/$FILE"
		;;
	"2") ;;
	esac
# Handle LibreOffice files (Excel/CSV)
elif [[ "$FILE" =~ \.(xlsx|csv)$ ]]; then
	ACTION=$(notify-send --replace-id="$DUNST_ID" -a LibreOffice "$FILE" --action="libreoffice" --icon=/usr/share/icons/hicolor/64x64/apps/libreoffice-calc.png)

	case "$ACTION" in
	"0")
		libreoffice --calc "$HOME/Downloads/$FILE"
		;;
	"2") ;;
	esac
fi
