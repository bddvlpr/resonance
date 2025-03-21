{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.tailscale;
in
{
  options.sysc.tailscale = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable tailscale.";
    };
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;

    environment.persistence."/persist".directories = [
      "/var/lib/tailscale"
    ];
  };
}
