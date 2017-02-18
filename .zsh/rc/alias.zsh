
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
alias source='source_auto-fu_syntax_conflict'
alias sc='screen'
alias l='less'
alias sudo='sudo -H'
alias cl='clear'
alias dircolor='eval `dircolors -b ~/.dir_colors`'   ## for Debian
alias quit='exit';

# グローバルエイリアス
alias -g G='| grep '  # e.x. dmesg lG CPU
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
alias -g C='| xsel -i -b'

# ls
alias la='ls -aF --show-control-char --color=auto'
alias lla='ls -alF --show-control-char --color=auto'
alias lal='ls -alF --show-control-char --color=auto'
alias ls='ls --show-control-char --color=auto'
alias ll='ls -l --show-control-char --color=auto'
alias l.='ls -d .[a-zA-Z]* --color=auto'

# chmod
alias 644='chmod 644'
alias 755='chmod 755'
alias 777='chmod 777'

# grep ファイル名表示, 行数表示, バイナリファイルは処理しない
alias grep='grep -H -n -I --color=auto'

## application ##
# vi
alias vi='vim'
alias v='vim'
alias sv='sudo vi'
alias nv='nvim'

## development ##
alias py='python'
alias gdb='gdb -silent'

# 今迄の履歴を簡単に辿る
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"' # AUTO_PUSHD が必要
# dirs -v  --  ディレクトリスタックを表示

# tmux
alias tmux='TERM=xterm-256color tmux'
alias t='TERM=xterm-256color tmux'

# suffix
alias -s {md,markdown,txt}='vim'
alias -s html='google-chrome'
alias -s rb='ruby'
alias -s py='python'
alias -s hs='runhaskell'
alias -s php='php -f'
alias -s {gif,jpg,jpeg,png,bmp}='eog'
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
