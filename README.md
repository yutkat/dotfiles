# dotfiles

![License](http://img.shields.io/badge/license-MIT-blue.svg)
[![](https://tokei.rs/b1/github/yutkat/dotfiles)](https://github.com/XAMPPRocky/tokei).
[![Join the chat at https://gitter.im/yutkat/dotfiles](https://badges.gitter.im/yutkat/dotfiles.svg)](https://gitter.im/yutkat/dotfiles?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Overview

My home dotfiles

![overview](https://raw.githubusercontent.com/yutkat/img/master/dotfiles/2021-03-21_19-07.png)

## Supported OS

- ArchLinux (recommend)
- Ubuntu
- Fedora

## Install

1. Download

    ```bash
    git clone https://github.com/yutkat/dotfiles.git
    cd dotfiles
    ```

1. Install

    ```bash
    ./install_scripts/dotsinstaller.sh
    ```

    or with GUI(i3/sway setup)

    ```bash
    ./install_scripts/dotsinstaller.sh --with-gui
    ```

1. zsh plugin install

    ```bash
    exec zsh
    ```

1. neovim plugin install

    ```bash
    vi +PackerSync +qall
    ```

1. Enjoy!

### Temporary Install

If you do not want to dirty your home directory

1. Download

    ```bash
    mkdir /tmp/tmphome
    cd /tmp/tmphome
    git clone https://github.com/yutkat/dotfiles.git
    cd dotfiles
    ```

1. Set HOME environment temporary

    ```bash
    export HOME=/tmp/tmphome
    ```

1. Install

    ```bash
    ./install_scripts/dotsinstaller.sh
    ```

    or with GUI(i3/sway setup)

    ```bash
    ./install_scripts/dotsinstaller.sh --with-gui
    ```

1. zsh plugin install

    ```bash
    exec zsh
    ```

1. neovim plugin install

    ```bash
    vi +PackerSync +qall
    ```

## Components

- zsh
- neovim
- tmux
- (optional) i3-gaps, sway

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

## Benchmarks

[https://yutkat.github.io/dotfiles/dev/bench/](https://yutkat.github.io/dotfiles/dev/bench/)
