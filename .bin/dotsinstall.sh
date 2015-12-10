#!/bin/bash
set -ue

helpmsg(){
    echo "Usage: $0 [--help|-h] [--without-tmux-extensions]" 0>&2
    echo ""
}

# コマンドの存在確認
chkcmd(){
    existcmd=`which $1 || true`
    if [ "$?" -ne 0 ];then
        echo "${1}コマンドが見つかりません"
        exit
    fi
}

whichdistro() {
    #which yum > /dev/null && { echo redhat; return; }
    #which zypper > /dev/null && { echo opensuse; return; }
    #which apt-get > /dev/null && { echo debian; return; }
    if [ -f /etc/debian_version ]; then
        echo debian; return;
    elif [ -f /etc/redhat-release ] ;then
        echo redhat; return;
    fi
}

checkinstall(){
    for PKG in "$@";do
        which $PKG > /dev/null 2>&1 || true
        if [ $? -ne 0 ]; then
            if [[ $DISTRO == "debian" ]];then
                sudo apt-get install -y $PKG
            elif [[ $DISTRO == "redhat" ]];then
                sudo yum install -y $PKG
            else
                :
            fi
        fi
    done
}

makedir(){
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
}

install_neobundle(){
    # ファイルの存在確認
    neobundle_dir="$HOME/.vim/bundle/neobundle.vim"
    if [ ! -f "$neobundle_dir/README.md" ];then
        echo "Installing NeoBundle.."
        echo ""
        mkdir -p "$HOME/.vim/bundle"
        git clone https://github.com/Shougo/neobundle.vim.git $neobundle_dir
    else
        echo "Pulling NeoBundle.."
        (cd $neobundle_dir; git pull origin master)
    fi
}

install_antigen(){
    # ファイルの存在確認
    zsh_antigen="$HOME/.zsh/antigen"
    if [ ! -d "$zsh_antigen" ];then
        echo "Installing antigen..."
        echo ""
        git clone https://github.com/zsh-users/antigen.git "$zsh_antigen"
    else
        echo "Pulling antigen..."
        (cd $zsh_antigen; git pull origin master)
    fi
}

install_tmux-powerline(){
    # install tmux-powerline
    tmux_powerline="$HOME/.tmux/tmux-powerline"
    if [ ! -d "$tmux_powerline" ];then
        echo "Installing tmux-powerline..."
        echo ""
        git clone https://github.com/erikw/tmux-powerline.git "$tmux_powerline"
    else
        echo "Pulling tmux-powerline..."
        (cd $tmux_powerline; git pull origin master)
    fi
}

install_tmuxinator(){
    # install tmuxinator
    which tmuxinator > /dev/null 2>&1 || true
    if [ "$?" -ne 0 ];then
        echo "Installing tmuxinator..."
        echo ""
        if [[ $DISTRO == "debian" ]];then
            sudo apt-get install -y ruby ruby-dev
        elif [[ $DISTRO == "redhat" ]];then
            sudo yum install -y ruby ruby-devel
        else
            :
        fi
        sudo gem install tmuxinator
        mkdir -p .tmuxinator/completion
        wget https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh -O ~/.tmuxinator/completion/tmuxinator.zsh
    fi
}

install_tmux-plugins(){
    # install tmux-plugins
    tmux_plugins="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tmux_plugins" ];then
        echo "Installing tmux-plugins..."
        echo ""
        mkdir -p $tmux_plugins
        git clone https://github.com/tmux-plugins/tpm $tmux_plugins
    else
        echo "Pulling tmux-plugins..."
        (cd $tmux_plugins; git pull origin master)
    fi
}

install_fzf(){
    fzf_dir="$HOME/.fzf"
    if [ ! -d "$fzf_dir" ];then
        echo "Installing fzf..."
        echo ""
        git clone --depth 1 https://github.com/junegunn/fzf.git $fzf_dir
        $fzf_dir/install --key-bindings --completion  --no-update-rc
    else
        echo "Pulling fzf..."
        $fzf_dir/install --key-bindings --completion  --no-update-rc
    fi
}


############
### main ###
############

WITHOUT_TMUX_EXTENSIONS="false"

while [ $# -gt 0 ];do
    case ${1} in
        --debug|-d)
            set -uex
        ;;
        --help|-h)
            helpmsg
            exit 1
        ;;
        --without-tmux-extensions)
            WITHOUT_TMUX_EXTENSIONS="true"
        ;;
        *)
        ;;
    esac
    shift
done


DISTRO=`whichdistro`

checkinstall zsh git vim tmux ctags bc
makedir
install_neobundle
install_antigen

if [[ $WITHOUT_TMUX_EXTENSIONS != "true" ]];then
    install_tmux-powerline
    install_tmuxinator
    install_tmux-plugins
fi

install_fzf

echo ""
echo ""
echo "#####################################################"
echo -e "\e[1;36m $(basename $0) install finish!!! \e[m"
echo "#####################################################"
echo ""


