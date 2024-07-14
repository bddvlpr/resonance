{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.obs;
in {
  options.sysc.obs = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable OBS.";
    };
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };

    home.persistence."/persist/home/bddvlpr".directories = [
      ".config/obs-studio"
    ];
  };
}
