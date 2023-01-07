#!/usr/bin/env bash

set -ue

function neovim_nightly() {
	mkdir -p ~/.local/
	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz | tar zx --strip-components 1 -C ~/.local/
	# for nvim-treesitter
	# https://github.com/nvim-treesitter/nvim-treesitter/blob/68e8181dbcf29330716d380e5669f2cd838eadb5/lua/nvim-treesitter/install.lua#L14
	checkinstall gcc
}

neovim_nightly
