{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.xdg;
in {
  options.sysc.xdg = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable XDG stuff.";
    };
  };

  config = mkIf cfg.enable {
    xdg.portal.enable = true;
  };
}
