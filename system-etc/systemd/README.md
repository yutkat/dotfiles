# system-etc/systemd

System units that are not managed declaratively (used on non-NixOS hosts;
NixOS declares equivalents in `nixos/`).

## nvbr0.service — sandboxed Neovim egress bridge

Creates the isolated, uplink-less bridge `nvbr0` (10.123.45.1/24) used as the
only egress path for the Neovim wall (`firejail --net=nvbr0`). Survives reboot.

Install (non-NixOS, e.g. X1C10):

```bash
sudo cp ~/dotfiles/system-etc/systemd/system/nvbr0.service /etc/systemd/system/
# If NetworkManager is in use, keep it from managing the bridge:
sudo cp ~/dotfiles/system-etc/NetworkManager/conf.d/nvbr0-unmanaged.conf /etc/NetworkManager/conf.d/
sudo systemctl reload NetworkManager

sudo systemctl daemon-reload
sudo systemctl enable --now nvbr0.service
ip -br addr show nvbr0          # expect 10.123.45.1/24, UP
```

If a host firewall is active, allow inbound on `nvbr0` to the proxy port, e.g.:

```bash
# nftables
sudo nft add rule inet filter input iifname "nvbr0" accept
# firewalld
sudo firewall-cmd --permanent --zone=trusted --change-interface=nvbr0 && sudo firewall-cmd --reload
```

Then apply home-manager and restart the proxy:

```bash
home-manager switch --flake ~/dotfiles#X1C10
systemctl --user restart tinyproxy-nvim
```

See `docs/superpowers/X1C10-bridge-setup.md` for the full Phase 2 context.
