{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.mpv;
in {
  options.sysc.mpv = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.mpv.override {
        scripts = [pkgs.mpv-discord];
      })
    ];
  };
}
