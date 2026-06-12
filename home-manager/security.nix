{ pkgs, ... }:

# Security-related tooling and services. Currently the Neovim runtime egress
# sandbox; add other hardening here as it grows.
{
  home.packages = with pkgs; [
    bubblewrap
    tinyproxy
  ];

  # === Neovim runtime egress sandbox (Phase 1) ===============================
  # A hostname-allowlist forward proxy that sandboxed Neovim is pointed at, plus
  # a desktop alert when the proxy denies a connection. The bubblewrap package
  # is the jail that confines Neovim's network access to this proxy.

  # --- Egress allowlist proxy ------------------------------------------------
  systemd.user.services.tinyproxy-nvim =
    let
      # Hostname allowlist (POSIX extended regex, matched case-insensitively
      # against the CONNECT destination host). Keep this list reviewed and tight.
      allowlist = pkgs.writeText "tinyproxy-nvim-allowlist" ''
        (^|\.)githubcopilot\.com$
        copilot-proxy\.githubusercontent\.com$
        (^|\.)anthropic\.com$
        (^|\.)wakapi\.dev$
        (^|\.)wakatime\.com$
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

  # --- Denial alert ----------------------------------------------------------
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
}
