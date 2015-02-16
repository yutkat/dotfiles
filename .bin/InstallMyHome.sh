#!/bin/bash

# コマンドの存在確認
chkcmd(){
    existcmd=`which $1`
    if [ "$?" -ne 0 ];then
        echo "${1}コマンドが見つかりません"
        exit
    fi
}

chkcmd zsh
chkcmd git 

# ディレクトリの存在確認
if [ ! -d "$HOME/.vim" ];then
    echo "$HOME/.vim not found. Auto Make it"
    mkdir "$HOME/.vim"
fi

if [ ! -d "$HOME/.vim/vimundo" ];then
    echo "$HOME/.vim/vimundo not found. Auto Make it"
    mkdir "$HOME/.vim/vimundo"
fi

if [ ! -d "$HOME/.zsh" ];then
    echo "$HOME/.zsh not found. Auto Make it"
    mkdir "$HOME/.zsh"
fi

if [ ! -d "$HOME/.trash" ];then
    echo "Make trash directory"
    mkdir "$HOME/.trash"
fi

# ファイルの存在確認
neobundle_readme="$HOME/.vim/bundle/neobundle.vim"
if [ ! -f "$neobundle_readme/README.md" ];then
    echo "Installing NeoBundle.."
    echo ""
    mkdir -p "$HOME/.vim/bundle"
    git clone https://github.com/Shougo/neobundle.vim.git $neobundle_readme
else
    (cd $neobundle_readme; git pull)
fi

# ファイルの存在確認
zsh_antigen="$HOME/.zsh/antigen"
if [ ! -d "$zsh_antigen" ];then
    echo "Installing antigen..."
    echo ""
    git clone https://github.com/zsh-users/antigen.git "$zsh_antigen"
else
    (cd $zsh_antigen; git pull)
fi

# clang lib
if [ ! -f /usr/lib/libclang.so ]; then
    sudo apt-get install -y libclang1
    sudo ln -s /usr/lib/x86_64-linux-gnu/libclang.so.1 /usr/lib/libclang.so
fi

# install tmux
which tmux > /dev/null 2>&1
if [ $? -eq 0 ]; then
    sudo apt-get install -y tmux
fi

# install tmux-powerline
tmux_powerline="$HOME/.tmux/tmux-powerline"
if [ ! -d "$tmux_powerline" ];then
    echo "Installing tmux-powerline..."
    echo ""
    git clone https://github.com/erikw/tmux-powerline.git "$tmux_powerline"
else
    (cd $tmux_powerline; git pull)
fi

# install tmuxinator
which tmuxinator > /dev/null 2>&1
if [ "$?" -ne 0 ];then
    echo "Installing tmuxinator..."
    echo ""
    sudo apt-get install -y ruby ruby-dev
    sudo gem install tmuxinator
    mkdir -p .tmuxinator/completion
    wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh -O ~/.tmuxinator/completion/tmuxinator.zsh
fi

# install tmux-plugins
tmux_plugins="$HOME/.tmux/plugins/tpm"
if [ ! -d "$tmux_plugins" ];then
    echo "Installing tmux-plugins..."
    echo ""
    mkdir -p $tmux_plugins
    git clone https://github.com/tmux-plugins/tpm $tmux_plugins
else
    (cd $tmux_plugins; git pull)
fi



