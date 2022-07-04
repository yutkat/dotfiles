#!/usr/bin/env bash

set -ue

function neovim_nightly() {
	mkdir -p ~/.local/
	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz | tar zx --strip-components 1 -C ~/.local/
}

neovim_nightly
