{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.bowl.networking;
in
{
  options.bowl.networking = {
    tailscale = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to install Tailscale VPN.";
      };
      excludeVPN = mkOption {
        type = types.bool;
        default = true;
        description = "Excludes Tailscale traffic from being handled by VPNs.";
      };
    };

    mullvad = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to install Mullvad VPN.";
      };
      enableGUI = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to install the GUI version of Mullvad. CLI-only is installed by default.";
      };
    };
  };

  config = {
    services = {
      tailscale = {
        inherit (cfg.tailscale) enable;
      };

      mullvad-vpn = {
        inherit (cfg.mullvad) enable;
        package = if cfg.mullvad.enableGUI then pkgs.mullvad-vpn else pkgs.mullvad;
      };
    };

    networking = {
      networkmanager.enable = true;

      firewall.checkReversePath = "loose";

      nftables = {
        enable = true;

        tables."mullvad-tailscale" = mkIf (cfg.tailscale.enable && cfg.tailscale.excludeVPN) {
          family = "inet";
          content = ''
            chain output {
                type route hook output priority -100; policy accept;
                ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            }

            chain input {
                type filter hook input priority -100; policy accept;
                ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            }
          '';
        };
      };
    };

    bowl.persist.entries = [
      { path = "/etc/NetworkManager"; }
      { path = "/etc/mullvad-vpn"; }
      { path = "/var/cache/mullvad-vpn"; }
      { path = "/var/cache/tailscale"; }
      { path = "/var/lib/tailscale"; }
    ];
  };
}
