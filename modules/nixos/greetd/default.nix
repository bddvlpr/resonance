{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) getExe mkIf mkOption types;

  cfg = config.sysc.greetd;
in {
  options.sysc.greetd = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use greetd for logging in purposes.";
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;

      vt = 2;

      settings = {
        default_session = {
          command = "${getExe pkgs.greetd.tuigreet} --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
}
