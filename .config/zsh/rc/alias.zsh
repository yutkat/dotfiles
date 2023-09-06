#==============================================================#
##          Aliases                                           ##
#==============================================================#

## common ##
alias rm='rm-trash'
alias del='rm -rf'
alias cp='cp -irfv'
alias mv='mv -iv'
alias ..='cd ..'
alias zcompile_zshrc='zcompile ~/.config/zsh/.zshrc'
alias rez='exec zsh'
alias sc='screen'
alias l='less'
alias less-plain='LESS="" less'
alias sudo='sudo -H '
alias cl='clear'
alias dircolor='eval `dircolors -b $ZHOMEDIR/dircolors`'
alias quit='exit'
alias truecolor-terminal='export COLORTERM=truecolor'
alias osc52='printf "\x1b]52;;%s\x1b\\" "$(base64 <<< "$(date +"%Y/%m/%d %H:%M:%S"): hello")"'
alias makej='make -j$(nproc)'

alias ka="killall" \
      trem="transmission-remote" \
      sdn="shutdown -h now" \
      update="sudo apt update && sudo apt upgrade"

## Networking ##
alias myiip="hostname -I | awk '{print $1}'" \
      myip="curl ifconfig.me"

## Clipboard ##
alias c="xclip -selection clipboard" \
      p="xclip -o -selection clipboard"

## YouTube and media aliases
alias yt="yt-dlp --embed-metadata -i" \
      yta="yt -x -f bestaudio/best"

# history
alias history-mem='fc -rl'
alias history-import='fc -RI'

# ls
alias la='ls -aF --color=auto'
alias lla='ls -alF --color=auto'
alias lal='ls -alF --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias l.='ls -d .[a-zA-Z]* --color=auto'

# chmod
alias 644='chmod 644'
alias 755='chmod 755'
alias 777='chmod 777'

# grep display filename, display line count, do not process binary files
alias gre='grep -H -n -I --color=auto'

## application ##
# vi
alias vi="$EDITOR"
alias sv="sudo $EDITOR"

## development ##
alias py='python'
alias gdb='gdb -silent -nh -x "$XDG_CONFIG_HOME"/gdb/init'

# Easily trace my history
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"' # AUTO_PUSHD is required

# man
alias man-ascii-color-code="man 4 console_codes"

# tmux
alias t='\tmux -2'
alias tmux='\tmux -2'
alias ta='\tmux -2 attach -d'

# xauth
alias xauth-copy="xauth list | tail -n 1 | awk '{printf \$3}' | pbcopy"

# udev
alias reload-udev-hwdb='sudo systemd-hwdb update && sudo udevadm trigger'


#==============================================================#
##          Global alias                                      ##
#==============================================================#

alias -g G='| grep '  # e.x. dmesg lG CPU
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
if [ "$WAYLAND_DISPLAY" != "" ]; then
	if builtin command -v wl-copy > /dev/null 2>&1; then
		alias -g Y='| wl-copy'
	fi
else
	if builtin command -v xsel > /dev/null 2>&1; then
		alias -g Y='| xsel -i -b'
	elif builtin command -v xclip > /dev/null 2>&1; then
		alias -g Y='| xclip -i -selection clipboard'
	fi
fi


#==============================================================#
##          Suffix                                            ##
#==============================================================#

alias -s {md,markdown,txt}="$EDITOR"
alias -s {html,gif,mp4}='x-www-browser'
alias -s rb='ruby'
alias -s py='python'
alias -s hs='runhaskell'
alias -s php='php -f'
alias -s {jpg,jpeg,png,bmp}='feh'
alias -s mp3=playmp3
function playmp3 {
    # mpc clear
    mpc add "$1"
    mpc play
    ncmpcpp
}
function extract() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: extract <file> [destination]"
        return 1
    fi

    local archive="$1"
    # Get the absolute path of the archive
    local abs_archive=$(realpath "$archive")
    local dest_dir="$2"

    if [[ -n "$dest_dir" ]]; then
        [[ ! -d "$dest_dir" ]] && mkdir -p "$dest_dir"
        pushd "$dest_dir" > /dev/null
    fi

    case "$abs_archive" in
        *.tar.gz|*.tgz) tar xzvf "$abs_archive" ;;
        *.tar.xz) tar Jxvf "$abs_archive" ;;
        *.zip) unzip "$abs_archive" ;;
        *.lzh) lha e "$abs_archive" ;;
        *.tar.bz2|*.tbz) tar xjvf "$abs_archive" ;;
        *.tar.Z) tar zxvf "$abs_archive" ;;
        *.gz) gzip -d "$abs_archive" ;;
        *.bz2) bzip2 -dc "$abs_archive" ;;
        *.Z) uncompress "$abs_archive" ;;
        *.tar) tar xvf "$abs_archive" ;;
        *.arj) unarj "$abs_archive" ;;
        *) echo "Unsupported archive format." && return 1 ;;
    esac

    if [[ -n "$dest_dir" ]]; then
        popd > /dev/null
    fi
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract


#==============================================================#
##          App                                               ##
#==============================================================#

# urxvt
alias Xresources-reload="xrdb -remove && xrdb -DHOME_ENV=\"$HOME\" -merge ~/.config/X11/Xresources"

# web-server
alias web-server='python -m SimpleHTTPServer 8000'

# generate password
alias generate-passowrd='openssl rand -base64 20'

# hdd mount
alias mount-myself='sudo mount -o uid=$(id -u),gid=$(id -g)'

# xhost
alias xhost-local='xhost local:'

# move bottom
alias move-bottom='tput cup $(($(stty size|cut -d " " -f 1))) 0 && tput ed'

# luajit patch https://github.com/LuaJIT/LuaJIT/issues/369
alias luajit="rlwrap luajit"

# translate
alias transr='trans ru:'
alias transe='trans :ru'

if builtin command -v nerdctl > /dev/null 2>&1; then
	alias docker='nerdctl'
fi

#==============================================================#
##          improvement command                               ##
#==============================================================#

function alias-improve() {
	if builtin command -v $(echo $2 | cut -d ' ' -f 1) > /dev/null 2>&1; then
		alias $1=$2
	fi
}

alias hdu='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias disk-usage='sudo ncdu --color dark -rr -x --exclude .git --exclude node_modules /'


#==============================================================#
##          ArchLinux                                         ##
#==============================================================#

if [ -f /etc/arch-release ] ;then
	# install
	alias pac-update='sudo pacman -Sy'
	alias pac-upgrade='sudo pacman -Syu'
	alias pac-upgrade-force='sudo pacman -Syyu'
	alias pac-install='sudo pacman -S'
	alias pac-remove='sudo pacman -Rs'
	# search remote package
	alias pac-search='pacman -Ss'
	alias pac-package-info='pacman -Si'
	# search local package
	alias pac-installed-list='pacman -Qs'
	alias pac-installed-package-info='pacman -Qi'
	alias pac-installed-list-export='pacman -Qqen' # import: sudo pacman -S - < pkglist.txt
	alias pac-installed-files='pacman -Ql'
	alias pac-unused-list='pacman -Qtdq'
	alias pac-search-from-path='pacman -Qqo'
	# search package from filename
	alias pac-included-files='pacman -Fl'
	alias pac-search-by-filename='pkgfile'
	# log
	alias pac-log='cat /var/log/pacman.log | \grep "installed\|removed\|upgraded"'
	alias pac-aur-packages='pacman -Qm'
	# etc
	alias pac-clean='sudo pacman -Scc'
	alias pac-get-update-pkg='pacman -Si $(pacman -Su --print --print-format %n)'
	alias pac-dependency='pacman -Qoq '
	# aur
	if builtin command -v paru > /dev/null 2>&1; then
		alias paru-installed-list='paru -Qm'
		alias paru-clean='paru -Sc'
	fi
fi

alias screencast='wf-recorder -g "$(slurp)" -f ~/Pictures/wf_$(date "+%y%m%d-%H%M%S").mp4'
alias xterm-modifyOtherKyes='xterm -xrm "*modifyOtherKeys:1"'
# alias xterm-modifyOtherKyes='xterm -xrm "*modifyOtherKeys:1" -xrm "*formatOtherKeys:1"'


#==============================================================#
##          Hash                                              ##
#==============================================================#

hash -d data=$XDG_DATA_HOME
hash -d zshdata=$XDG_DATA_HOME/zsh
hash -d zshplugins=$XDG_DATA_HOME/zsh/zinit/plugins
hash -d nvimdata=$XDG_DATA_HOME/nvim
hash -d nvimplugins=$XDG_DATA_HOME/nvim/lazy
