
#==============================================================#
##          Aliases                                           ##
#==============================================================#

## common ##
alias rm='rm-trash'
alias del='rm -rf'
alias cp='cp -irf'
alias mv='mv -i'
alias ..='cd ..'
alias zcompile='zcompile ~/.zshrc'
alias rez='exec zsh'
alias sc='screen'
alias l='less'
alias less-plain='LESS="" less'
alias sudo='sudo -H'
alias cl='clear'
alias dircolor='eval `dircolors -b $ZHOMEDIR/dircolors`'
alias quit='exit'
alias truecolor-terminal='export COLORTERM=truecolor'

# グローバルエイリアス
alias -g G='| grep '  # e.x. dmesg lG CPU
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
if builtin command -v xsel > /dev/null 2>&1; then
  alias -g C='| xsel -i -b'
elif builtin command -v xclip > /dev/null 2>&1; then
  alias -g C='| xclip -i -selection clipboard'
fi

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
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias nv='nvim'

## development ##
alias py='python'
alias gdb='gdb -silent'

# 今迄の履歴を簡単に辿る
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"' # AUTO_PUSHD が必要
# dirs -v  --  ディレクトリスタックを表示

# tmux
alias t='tmux -2'
alias tmux='tmux -2'
alias ta='tmux -2 attach -d'

# xauth
alias xauth-copy="xauth list | tail -n 1 | awk '{printf \$3}' | pbcopy"


#==============================================================#
##          Suffix                                            ##
#==============================================================#

alias -s {md,markdown,txt}="$EDITOR"
alias -s html='chromium'
alias -s rb='ruby'
alias -s py='python'
alias -s hs='runhaskell'
alias -s php='php -f'
alias -s {gif,jpg,jpeg,png,bmp}='feh'
alias -s gif='chromium'
alias -s mp3='mplayer'
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf "$1";;
    *.tar.xz) tar Jxvf "$1";;
    *.zip) unzip "$1";;
    *.lzh) lha e "$1";;
    *.tar.bz2|*.tbz) tar xjvf "$1";;
    *.tar.Z) tar zxvf "$1";;
    *.gz) gzip -d "$1";;
    *.bz2) bzip2 -dc "$1";;
    *.Z) uncompress "$1";;
    *.tar) tar xvf "$1";;
    *.arj) unarj "$1";;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract


#==============================================================#
##          App                                               ##
#==============================================================#

# urxvt
alias Xresources-reload="xrdb -remove && xrdb -DHOME_ENV=\"$HOME\" -merge ~/.Xresources"

# profile
alias zshrc_profiler='ZSHRC_PROFILE=1 zsh -i -c zprof'
alias zsh_startuptime='for i in $(seq 1 10); do time zsh -i -c exit; done'

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

# translate
alias transj='trans ja:'
alias tj='trans ja:'

# vim
alias vim_startuptime='vi --startuptime /tmp/vim_startuptime.log -c "quit" && tail -n 1 /tmp/vim_startuptime.log | cut -d " " -f1 | tr -d "\n" && echo " [ms]"'
alias vim_startuptime_slower_than_default='echo "scale=3; $(vi --startuptime /tmp/vim_startuptime.log -c "quit" > /dev/null && tail -n 1 /tmp/vim_startuptime.log | cut -d " " -f1) / $(vi -u DEFAULTS --startuptime /tmp/vim_startuptime_def.log  -c "quit" > /dev/null && tail -n 1 /tmp/vim_startuptime_def.log | cut -d " " -f1)" | bc | xargs -i echo {}x slower your Vim than the default.'


#==============================================================#
##          improvement command                               ##
#==============================================================#

function alias-improve() {
  if builtin command -v $(echo $2 | cut -d ' ' -f 1) > /dev/null 2>&1; then
    alias $1=$2
  fi
}

alias-improve hcat bat
alias-improve hfind fd
alias-improve hdu 'ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias-improve disk-usage 'sudo ncdu --color dark -rr -x --exclude .git --exclude node_modules /'
alias-improve help tldr
alias-improve ls exa

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
  alias pac-search='sudo pacman -Ss'
  alias pac-package-info='sudo pacman -Si'
  # search local package
  alias pac-installed-list='sudo pacman -Qs'
  alias pac-installed-package-info='sudo pacman -Qi'
  alias pac-installed-list-export='sudo pacman -Qqen' # import: sudo pacman -S - < pkglist.txt
  alias pac-installed-files='sudo pacman -Ql'
  alias pac-unused-list='sudo pacman -Qtdq'
  alias pac-search-from-path='sudo pacman -Qqo'
  # search package from filename
  alias pac-included-files='sudo pacman -Fl'
  alias pac-search-by-filename='sudo pkgfile'
  # log
  alias pac-log='cat /var/log/pacman.log | \grep "installed\|removed\|upgraded"'
  alias pac-aur-packages='sudo pacman -Qm'
  # etc
  alias pac-clean='sudo pacman -Sc'
  # aur
  if builtin command -v yay > /dev/null 2>&1; then
    alias yay-installed-list='yay -Qm'
    alias yay-clean='yay -Sc'
  fi
fi


