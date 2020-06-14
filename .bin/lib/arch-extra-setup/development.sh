#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed rustup clang gcc gdb make cmake
sudo pacman -S --noconfirm --needed docker xorg-xhost jq

rustup install stable
rustup component add rust-analysis rust-src rustfmt clippy

