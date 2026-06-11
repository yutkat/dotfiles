{
  pkgs,
  config,
  lib,
  inputs,
  username,
  ...
}:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    nodejs
    file
    zip
    unzip
    eza
    wakatime-cli
    mise
    direnv
    nix-direnv
    translate-shell
    gh
    ghq
    zoxide
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
    jq
    vale
    zsh
    wget
    rustc
    cargo
    bun
    node-gyp-build
    bubblewrap
    tinyproxy
  ];
  programs = {
    gpg = {
      enable = true;
    };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    defaultCacheTtl = 604800;
    maxCacheTtl = 604800;
  };
  # --- Neovim egress allowlist proxy (Phase 1) -------------------------------
  systemd.user.services.tinyproxy-nvim =
    let
      # Hostname allowlist (POSIX extended regex, matched case-insensitively
      # against the CONNECT destination host). Keep this list reviewed and tight.
      allowlist = pkgs.writeText "tinyproxy-nvim-allowlist" ''
        (^|\.)githubcopilot\.com$
        copilot-proxy\.githubusercontent\.com$
        (^|\.)anthropic\.com$
        (^|\.)wakapi\.dev$
        (^|\.)wakatime\.dev$
        (^|\.)github\.com$
        (^|\.)githubusercontent\.com$
        codeload\.github\.com$
        (^|\.)registry\.npmjs\.org$
        (^|\.)pypi\.org$
        (^|\.)files\.pythonhosted\.org$
        (^|\.)crates\.io$
        static\.crates\.io$
        (^|\.)proxy\.golang\.org$
        (^|\.)mason-registry\.dev$
      '';
      conf = pkgs.writeText "tinyproxy-nvim.conf" ''
        Port 8888
        Listen 127.0.0.1
        Listen 10.123.45.1
        Timeout 600
        MaxClients 50
        StartServers 1
        FilterDefaultDeny Yes
        Filter "${allowlist}"
        FilterType ere
        FilterCaseSensitive No
        ConnectPort 443
        ConnectPort 563
        Syslog On
        LogLevel Connect
      '';
    in
    {
      Unit = {
        Description = "Egress hostname-allowlist proxy for sandboxed Neovim";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.tinyproxy}/bin/tinyproxy -d -c ${conf}";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "default.target" ];
    };
  # Desktop notification when the egress allowlist denies a connection (an
  # allowlist miss, or a suspicious destination). Follows the tinyproxy journal
  # and fires notify-send on denial lines, so you don't have to watch the log.
  systemd.user.services.tinyproxy-nvim-alert =
    let
      script = pkgs.writeShellScript "tinyproxy-nvim-alert" ''
        ${pkgs.systemd}/bin/journalctl --user -n0 -f -o cat -u tinyproxy-nvim \
          | ${pkgs.gnugrep}/bin/grep --line-buffered -iE 'proxying refused' \
          | ${pkgs.gnugrep}/bin/grep --line-buffered -ivE 'dc\.services\.visualstudio\.com' \
          | while IFS= read -r line; do
              ${pkgs.libnotify}/bin/notify-send -u critical -a snvim \
                "snvim: egress blocked" "$line"
            done
      '';
    in
    {
      Unit = {
        Description = "Desktop alert on sandboxed-Neovim egress denials";
        After = [ "tinyproxy-nvim.service" ];
        Wants = [ "tinyproxy-nvim.service" ];
      };
      Service = {
        ExecStart = "${script}";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = [ "default.target" ];
    };
  home.activation.valeSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dotfiles_path="${config.dotfiles.symlinks.path}"
    if [ -f "$dotfiles_path/.vale.ini" ]; then
      (cd "$dotfiles_path" && ${pkgs.vale}/bin/vale sync)
    fi
  '';
}
