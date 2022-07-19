
#--------------------------------------------------------------#
##          Environment Variables                             ##
#--------------------------------------------------------------#

export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LANG="${LANG:-en_US.UTF-8}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
# export ZDOTDIR=$HOME
export ZDOTDIR=$HOME/.config/zsh
export ZHOMEDIR=$HOME/.config/zsh
export ZRCDIR=$ZHOMEDIR/rc
export ZDATADIR=$XDG_DATA_HOME/zsh

setopt no_global_rcs

typeset -fuz zkbd
typeset -U path PATH manpath sudo_path
typeset -xT SUDO_PATH sudo_path

path=(
    $HOME/.local/share/zsh/zinit/polaris/bin(N-/)
    $HOME/.bin(N-/)
    $HOME/bin(N-/)
    $HOME/.local/bin(N-/)
    $HOME/go/bin(N-/)
    $HOME/.go/bin(N-/)
    $HOME/.cargo/bin(N-/)
    $HOME/.rustup/toolchains/*/bin(N-/)
    $HOME/.nimble/bin(N-/)
    $HOME/.yarn/bin(N-/)
    # ./node_modules/.bin(N-/) # don't work relative path. so this set automatically by chpwd
    $HOME/.config/yarn/global/node_modules/.bin(N-/)
    $HOME/.deno/bin(N-/)
    $path
)
export PATH

# zsh関数のサーチパス
fpath=(
  $HOME/.zfunc(N-/)
  $ZHOMEDIR/zfunc(N-/)
  $ZHOMEDIR/completions.local(N-/)
  $ZHOMEDIR/completions(N-/)
  /usr/local/share/zsh/site-functions(N-/)
  /usr/share/zsh/site-functions(N-/)
  $fpath
)
export FPATH

if SHELL=$(builtin command -v zsh); then
  export SHELL
else
  unset SHELL
fi

if builtin command -v nvim > /dev/null 2>&1; then
  export EDITOR=${EDITOR:-nvim}
else
  export EDITOR=${EDITOR:-vim}
fi
export PAGER=less
export LESS='--no-init -R --shift 4 --LONG-PROMPT --quit-if-one-screen'
if builtin command -v lesspipe.sh > /dev/null 2>&1; then
  export LESSOPEN="|lesspipe.sh %s"
fi

if builtin command -v dircolors > /dev/null 2>&1 && [ -f "$ZHOMEDIR/dircolors" ]; then
  eval $(dircolors "$ZHOMEDIR/dircolors")
  export USER_LS_COLORS=$LS_COLORS
else
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

if [ -f "$HOME/.zshenv.local" ]; then
  source "$HOME/.zshenv.local"
fi
if [ -f "$ZHOMEDIR/.zshenv.local" ]; then
  source "$ZHOMEDIR/.zshenv.local"
fi

export GOPATH=$HOME/.go

export PS4='+%N:%i> '

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

export NEWT_COLORS='
    root=white,black
    border=black,lightgray
    window=lightgray,lightgray
    shadow=black,gray
    title=black,lightgray
    button=black,cyan
    actbutton=white,cyan
    compactbutton=black,lightgray
    checkbox=black,lightgray
    actcheckbox=lightgray,cyan
    entry=black,lightgray
    disentry=gray,lightgray
    label=black,lightgray
    listbox=black,lightgray
    actlistbox=black,cyan
    sellistbox=lightgray,black
    actsellistbox=lightgray,black
    textbox=black,lightgray
    acttextbox=black,cyan
    emptyscale=,gray
    fullscale=,cyan
    helpline=white,black
    roottext=lightgrey,black
'
