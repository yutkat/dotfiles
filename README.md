# dotfiles

[![total lines](https://tokei.rs/b1/github/yutkat/dotfiles)](https://github.com/XAMPPRocky/tokei)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/yutkat/dotfiles)
![GitHub repo size](https://img.shields.io/github/repo-size/yutkat/dotfiles)

![GitHub commit week activity](https://img.shields.io/github/commit-activity/w/yutkat/dotfiles)
![GitHub commit month activity](https://img.shields.io/github/commit-activity/m/yutkat/dotfiles)
![GitHub commit year activity](https://img.shields.io/github/commit-activity/y/yutkat/dotfiles)

## Overview

My home dotfiles

![overview](https://github.com/yutkat/dotfiles/assets/8683947/e4d944e8-3f5d-412f-aff6-2a363cdda0ce)

## Supported OS

- Arch Linux (recommend)
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

   or with GUI(Hyprland/i3/sway setup)

   ```bash
   ./install.sh --gui
   ```

1. zsh plugin install

   ```bash
   exec zsh
   ```

1. neovim plugin install

   ```bash
   vi --headless -c 'Lazy! sync' -c 'qall'
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

   or with GUI(Hyprland/i3/sway setup)

   ```bash
   ./install.sh --gui
   ```

1. zsh plugin install

   ```bash
   exec zsh
   ```

1. neovim plugin install

   ```bash
   vi --headless -c 'Lazy! sync' -c 'qall'
   ```

## Components

- zsh
- neovim
- wezterm
- (optional) Hyprland, i3, sway

## Usage

### Frequently used shortcuts

#### wezterm

| key                  | action        |
| -------------------- | ------------- |
| Alt-h/j/k/l          | switch window |
| Alt-j                | close window  |
| Alt-k                | create window |
| S-Up/Down/Left/Right | switch pane   |

#### Hyprland/i3/sway

| key             | action         |
| --------------- | -------------- |
| Mod-h/j/k/l     | switch window  |
| Mod-S-h/j/k/l   | move window    |
| Mod-C-S-h/j/k/l | move workspace |

## Insight

<!-- Made with [OSS Insight](https://ossinsight.io/) -->

### Activity

<a href="https://next.ossinsight.io/widgets/official/compose-last-28-days-stats?repo_id=44688041" target="_blank" style="display: block" align="center"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://next.ossinsight.io/widgets/official/compose-last-28-days-stats/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=dark" width="655" height="auto"> <img alt="Performance Stats of yutkat/dotfiles - Last 28 days" src="https://next.ossinsight.io/widgets/official/compose-last-28-days-stats/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=light" width="655" height="auto"> </picture></a>

### Changes

<a href="https://next.ossinsight.io/widgets/official/analyze-repo-loc-per-month?repo_id=44688041" target="_blank" style="display: block" align="center"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://next.ossinsight.io/widgets/official/analyze-repo-loc-per-month/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=dark" width="721" height="auto"> <img alt="Lines of Code Changes of yutkat/dotfiles" src="https://next.ossinsight.io/widgets/official/analyze-repo-loc-per-month/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=light" width="721" height="auto"> </picture></a>


### Star History

<a href="https://next.ossinsight.io/widgets/official/analyze-repo-stars-history?repo_id=44688041" target="_blank" style="display: block" align="center"> <picture> <source media="(prefers-color-scheme: dark)" srcset="https://next.ossinsight.io/widgets/official/analyze-repo-stars-history/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=dark" width="721" height="auto"> <img alt="Star History of yutkat/dotfiles" src="https://next.ossinsight.io/widgets/official/analyze-repo-stars-history/thumbnail.png?repo_id=44688041&image_size=auto&color_scheme=light" width="721" height="auto"> </picture></a>
