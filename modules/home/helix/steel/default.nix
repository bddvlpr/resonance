{
  lib,
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (inputs.helix-steel.packages.${pkgs.system}) helix;

  cfg = config.sysc.helix;
in {
  config = mkIf (cfg.enable
    && cfg.enableSteel) {
    programs.helix = {
      package = helix;
    };
    xdg.configFile = {
      "helix/helix.scm".source = ./helix.scm;
      "helix/init.scm".source = ./init.scm;
    };
  };
}
