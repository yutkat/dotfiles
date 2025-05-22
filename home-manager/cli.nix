{ pkgs, config, lib, inputs, username, ... }:

{
	home.packages = with pkgs; [
		git
		zsh
		neovim
		gcc
		gnumake
		python3
		nodejs
		deno
		zip
		unzip
		eza
		wakatime-cli
		mise
		direnv
		translate-shell
		gh
		ripgrep
		delta
		tldr
		trashy
		bat
		fd
		procs
		mmv-go
		fzf
		sqlite
	];
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    zsh = {
      enable = true;
    };  
		gpg = {
			enable = true;
		};
	};
	services.gpg-agent = {
		enable = true;
		enableSshSupport = true;
		pinentryPackage = pkgs.pinentry-curses;
	};
}
