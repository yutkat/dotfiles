# dotfiles

![License](http://img.shields.io/badge/license-MIT-blue.svg)
![Support OS](https://img.shields.io/badge/OS-arch%2Fubuntu%2Fcent%2Ffedora%2Falpine-blue.svg)
[![Join the chat at https://gitter.im/yutkat/dotfiles](https://badges.gitter.im/yutkat/dotfiles.svg)](https://gitter.im/yutkat/dotfiles?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Overview

My home dotfiles

![overview](https://raw.githubusercontent.com/yutkat/img/master/dotfiles/overview.png)

## Install

1. Download  

    ```bash
    git clone https://github.com/yutkat/dotfiles.git
    ```

1. Install  

    ```bash
    ./dotfiles/.bin/dotsinstaller.sh
    ```

    or with GUI(i3/sway setup)

    ```bash
    ./dotfiles/.bin/dotsinstaller.sh --with-gui
    ```

1. zsh plugin install  

    ```bash
    exec zsh
    ```

1. neovim plugin install  

    ```bash
    vi +PlugInstall +qall
    ```

1. Enjoy!

### Temporary Install

If you do not want to dirty your home directory

1. Download

    ```bash
    mkdir /tmp/tmphome
    cd /tmp/tmphome
    git clone https://github.com/yutkat/dotfiles.git
    ```

1. Set HOME environment temporary  

    ```bash
    export HOME=/tmp/tmphome
    ```

1. Install  

    ```bash
    ./dotfiles/.bin/dotsinstaller.sh
    ```

    or with GUI(i3/sway setup)

    ```bash
    ./dotfiles/.bin/dotsinstaller.sh --with-gui
    ```

1. zsh plugin install  

    ```bash
    exec zsh
    ```

1. neovim plugin install  

    ```bash
    vi +PlugInstall +qall
    ```

## Components

- zsh
- neovim
- tmux
- i3-gaps(optional), sway

## Usage

### Frequently used shortcuts

#### tmux

|key|action|
|---|---|
|Alt-h/j/k/l|switch window|
|Alt-j|close window|
|Alt-k|create window|
|S-Up/Down/Left/Right|switch pane|

#### i3

|key|action|
|---|---|
|Mod-h/j/k/l|switch window|
|Mod-S-h/j/k/l|move window|
|Mod-C-S-h/j/k/l|move workspace|

