{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.peripheral;
in
{
  options.bowl.peripheral = {
    bluetooth = {
      enable = lib.mkEnableOption "Bluetooth services" // {
        default = true;
      };

      persist = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Automatically persist Bluetooth files.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;

      environment.systemPackages = [ pkgs.bluetuith ];

      bowl.persist.entries = lib.mkIf cfg.bluetooth.persist [
        { path = "/var/lib/bluetooth"; }
      ];
    })
  ];
}
