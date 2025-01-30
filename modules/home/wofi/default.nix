{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.wofi;
in {
  options.sysc.wofi = {
    enable = mkOption {
      type = types.bool;
      default = config.sysc.hyprland.enable;
      description = "Whether to enable Wofi.";
    };
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      style = ''
        #window {
          background-color: rgba(0.4, 0.4, 0.4, 0.25);
        }
      '';
    };

    stylix.targets.wofi.enable = false;
  };
}
