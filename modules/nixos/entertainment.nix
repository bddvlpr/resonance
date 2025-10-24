{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.entertainment;
in
{
  options.bowl.entertainment = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux;
      description = "Whether to enable entertainment packages.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
