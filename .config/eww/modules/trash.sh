#!/bin/sh

case "$1" in
    --clean)
        if [ -x /bin/trash-empty ]; then
            trash-empty
        else 
            rm -rf ~/.local/share/Trash/files
            rm -rf ~/.local/share/Trash/info
            mkdir ~/.local/share/Trash/files
            mkdir ~/.local/share/Trash/info
        fi
        echo "0"
        ;;
    *)
        nfiles=$(find ~/.local/share/Trash/files/ -maxdepth 1 | wc -l)
        echo $((nfiles-1))
        ;;
    esac
