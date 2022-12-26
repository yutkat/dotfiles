
#==============================================================#
##          Aliases                                           ##
#==============================================================#

## common ##
alias rm='rm-trash'
alias del='rm -rf'
alias cp='cp -irf'
alias mv='mv -i'
alias ..='cd ..'
alias zcompile_zshrc='zcompile ~/.zshrc'
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

# grep ファイル名表示, 行数表示, バイナリファイルは処理しない
alias gre='grep -H -n -I --color=auto'

## application ##
# vi
alias vi="$EDITOR"
alias sv="sudo $EDITOR"

## development ##
alias py='python'
alias gdb='gdb -silent -nh -x "$XDG_CONFIG_HOME"/gdb/init'

# 今迄の履歴を簡単に辿る
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"' # AUTO_PUSHD が必要
# dirs -v  --  ディレクトリスタックを表示

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
alias -s mp3='mplayer'
function extract() {
	case $1 in
		*.tar.gz|*.tgz) tar xzvf "$1" ;;
		*.tar.xz) tar Jxvf "$1" ;;
		*.zip) unzip "$1" ;;
		*.lzh) lha e "$1" ;;
		*.tar.bz2|*.tbz) tar xjvf "$1" ;;
		*.tar.Z) tar zxvf "$1" ;;
		*.gz) gzip -d "$1" ;;
		*.bz2) bzip2 -dc "$1" ;;
		*.Z) uncompress "$1" ;;
		*.tar) tar xvf "$1" ;;
		*.arj) unarj "$1" ;;
	esac
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
alias transj='trans ja:'
alias tj='trans ja:'
alias te='trans :ja'

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
