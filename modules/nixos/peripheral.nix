{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.bowl.peripheral;
in
{
  options.bowl.peripheral = {
    bluetooth = {
      enable = mkEnableOption "Bluetooth services" // {
        default = true;
      };

      persist = mkOption {
        type = types.bool;
        default = true;
        description = "Automatically persist Bluetooth files.";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;

      environment.systemPackages = [ pkgs.bluetuith ];

      bowl.persist.entries = mkIf cfg.bluetooth.persist [
        { path = "/var/lib/bluetooth"; }
      ];
    })
  ];
}
