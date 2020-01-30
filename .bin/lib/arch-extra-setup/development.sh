#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed rustup go-pie clang gcc gdb make cmake
sudo pacman -S --noconfirm --needed docker xorg-xhost jq

yay -S --noconfirm --needed ghq-bin
