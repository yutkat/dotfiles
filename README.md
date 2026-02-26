# dotfiles

[![total lines](https://www.aschey.tech/tokei/github/yutkat/dotfiles)](https://github.com/XAMPPRocky/tokei)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/yutkat/dotfiles)
![GitHub repo size](https://img.shields.io/github/repo-size/yutkat/dotfiles)

![GitHub commit week activity](https://img.shields.io/github/commit-activity/w/yutkat/dotfiles)
![GitHub commit month activity](https://img.shields.io/github/commit-activity/m/yutkat/dotfiles)
![GitHub commit year activity](https://img.shields.io/github/commit-activity/y/yutkat/dotfiles)

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fyutkat%2Fdotfiles.svg?type=shield&issueType=license)](https://app.fossa.com/projects/git%2Bgithub.com%2Fyutkat%2Fdotfiles?ref=badge_shield&issueType=license)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fyutkat%2Fdotfiles.svg?type=shield&issueType=security)](https://app.fossa.com/projects/git%2Bgithub.com%2Fyutkat%2Fdotfiles?ref=badge_shield&issueType=security)

## Overview

My home dotfiles

![overview](https://github.com/user-attachments/assets/a2d31f0e-ffa0-41cc-8bed-15bdee1de671)

## Supported OS

### GUI

- NixOS (recommend)
- Arch Linux (You must install various GUI apps yourself)

### CLI

- NixOS
- Arch Linux
- Ubuntu
- Fedora

## Install (NixOS)

1. Download

   ```bash
   git clone https://github.com/yutkat/dotfiles.git
   cd dotfiles
   ```

2. Edit Configuration

   ```bash
   vi flake.nix
   # myHosts = {
   ```

3. Install nix (+flake +home-manager)

   ```bash
   ./install.sh
   ```

4. Setup (installing tools and linking to dotfiles)

   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   ```

5. zsh plugin install

   ```bash
   exec zsh
   ```

6. mise upgrade-all

   ```bash
   mise upgrade
   ```

7. neovim plugin install

   ```bash
   vi --headless -c 'Lazy! sync' -c 'qall'
   ```

8. Enjoy!

## Install (Other OS)

1. Download

   ```bash
   git clone https://github.com/yutkat/dotfiles.git
   cd dotfiles
   ```

2. Edit Configuration

   ```bash
   vi flake.nix
   # myHosts = {
   ```

3. Install nix (+flake +home-manager)

   ```bash
   ./install.sh
   ```

4. Setup (installing tools and linking to dotfiles)

   ```bash
   # Default user and hostname
   home-manager switch --flake .#<hostname>
   ```

5. zsh plugin install

   ```bash
   exec zsh
   ```

6. mise upgrade-all

   ```bash
   mise upgrade
   ```

7. neovim plugin install

   ```bash
   vi --headless -c 'Lazy! sync' -c 'qall'
   ```

## Temporary Install

If you do not want to dirty your home directory

1. Setup the container

   ```bash
   docker run -it --rm archlinux:latest /bin/bash
   ```

2. Setup the environment

   ```bash
   pacman -Sy --noconfirm sudo git
   useradd -m -s /bin/bash test
   echo 'test ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
   su - test
   ```

3. Download

   ```bash
   git clone https://github.com/yutkat/dotfiles.git
   cd dotfiles
   ```

4. Install

   ```bash
   ./install.sh --single
    exec bash
   ```

5. Setup (installing tools and linking to dotfiles)

   ```bash
   home-manager switch --flake .#test
   ```

6. zsh plugin install

   ```bash
   exec zsh
   ```

7. mise upgrade-all

   ```bash
   mise upgrade
   ```

8. neovim plugin install

   ```bash
   vi --headless -c 'Lazy! sync' -c 'qall'
   ```

## Components

- zsh
- neovim
- wezterm
- (optional) Hyprland

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
