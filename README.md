# dotfiles

![GitHub commit year activity](https://img.shields.io/github/commit-activity/y/yutkat/dotfiles)
![GitHub commit month activity](https://img.shields.io/github/commit-activity/m/yutkat/dotfiles)
![GitHub commit week activity](https://img.shields.io/github/commit-activity/w/yutkat/dotfiles)
[![total lines](https://tokei.rs/b1/github/yutkat/dotfiles)](https://github.com/XAMPPRocky/tokei)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/yutkat/dotfiles)
![GitHub repo size](https://img.shields.io/github/repo-size/yutkat/dotfiles)

## Overview

My home dotfiles

![overview](https://raw.githubusercontent.com/yutkat/img/main/dotfiles/2022-05-05_04-45.png)

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
   ./install.sh
   ```

   or with GUI(i3/sway setup)

   ```bash
   ./install.sh --gui
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
   ./install.sh
   ```

   or with GUI(i3/sway setup)

   ```bash
   ./install.sh --gui
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
- wezterm
- (optional) i3-gaps, sway

## Usage

### Frequently used shortcuts

#### wezterm

| key                  | action        |
| -------------------- | ------------- |
| Alt-h/j/k/l          | switch window |
| Alt-j                | close window  |
| Alt-k                | create window |
| S-Up/Down/Left/Right | switch pane   |

#### i3/sway

| key             | action         |
| --------------- | -------------- |
| Mod-h/j/k/l     | switch window  |
| Mod-S-h/j/k/l   | move window    |
| Mod-C-S-h/j/k/l | move workspace |

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=yutkat/dotfiles&type=Date)](https://star-history.com/#yutkat/dotfiles&Date)

## Benchmarks

[https://yutkat.github.io/dotfiles/dev/bench/](https://yutkat.github.io/dotfiles/dev/bench/)
