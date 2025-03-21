{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.avahi;
in
{
  options.sysc.avahi = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable avahi resolving.";
    };
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
