{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.mpv;
in
{
  options.sysc.mpv = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    package = mkOption {
      type = types.package;
      default = pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [ mpv-discord ];
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
