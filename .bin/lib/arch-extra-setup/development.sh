#!/bin/bash
sudo pacman -S --noconfirm --needed rustup go clang gcc gdb make cmake
sudo pacman -S --noconfirm --needed docker xorg-xhost jq

go get github.com/motemen/ghq
