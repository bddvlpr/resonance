{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.cura;
in {
  options.sysc.cura = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Cura.";
    };
  };

  config = mkIf cfg.enable {
    home = let
      inherit (inputs.nixpkgs-stable.legacyPackages.${pkgs.system}) cura;
    in {
      packages = with pkgs; [cura cura5];

      persistence."/persist/home/bddvlpr".directories = [
        ".config/cura"
        ".local/share/cura"
      ];
    };
  };
}
