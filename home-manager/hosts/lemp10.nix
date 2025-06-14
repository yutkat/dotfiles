{ pkgs, config, lib, ... }:

{
	home.packages = with pkgs; [
	  claude-code
	];
}