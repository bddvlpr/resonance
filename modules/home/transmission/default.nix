{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.transmission;
in
{
  options.sysc.transmission = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.transmission_4-gtk ];
    home.persistence."/persist/home/bddvlpr".directories = [
      ".config/transmission"
    ];
  };
}
