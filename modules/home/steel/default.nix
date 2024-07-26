{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (inputs.nix-steel.packages.${pkgs.system}) steel;

  cfg = config.sysc.steel;
in {
  options.sysc.steel = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable steel.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [steel];
    home.sessionVariables = {
      STEEL_HOME = "${steel}/home";
      STEEL_LSP_HOME = "/home/bddvlpr/temp-lsp";
    };
  };
}
