{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.gnome-keyring;
in {
  options.sysc.gnome-keyring = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable gnome-keyring.";
    };
  };

  config = mkIf cfg.enable {
    services.gnome-keyring.enable = true;

    home = {
      packages = [pkgs.gcr];
      persistence."/persist/home/bddvlpr".directories = [
        ".local/share/keyrings"
      ];
    };
  };
}
