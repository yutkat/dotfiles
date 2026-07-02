{ pkgs, ... }:

# Isolated, uplink-less bridge: the only egress path for sandboxed Neovim
# (snvim --net=nvbr0). The sandbox reaches tinyproxy on 10.123.45.1; a firejail
# netfilter drops everything else. No uplink/NAT -- the proxy egresses as a
# normal host process. See docs/superpowers/specs/2026-06-09-neovim-runtime-sandbox-design.md
{
  networking.networkmanager.unmanaged = [ "interface-name:nvbr0" ];
  networking.firewall.trustedInterfaces = [ "nvbr0" ];
  systemd.services.nvbr0 = {
    description = "Isolated bridge for sandboxed Neovim egress";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-pre.target" ];
    before = [ "network.target" ];
    path = [ pkgs.iproute2 ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ip link show nvbr0 >/dev/null 2>&1 || ip link add nvbr0 type bridge
      ip addr replace 10.123.45.1/24 dev nvbr0
      ip link set nvbr0 up
    '';
    preStop = "ip link del nvbr0";
  };
}
