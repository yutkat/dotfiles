# Path to the sqlite shared library, exported as LIBSQLITE to fix the
# libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
# Shared by home.nix and nixos/configuration.nix.
pkgs: "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
